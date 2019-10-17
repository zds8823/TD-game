import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:game_1/components/fly.dart';
import 'package:game_1/components/map.dart';

import 'dart:math';
import 'package:flutter/gestures.dart';


class l_game extends Game {
  Size screenSize;
  double tileSize;
  List<Fly> flies;
  Random rnd;

  l_game() {
    initialize();
  }
  void initialize() async {
    flies = List<Fly>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());

    spawnFly();
  }

  void spawnFly() {
    for (double i = 0; i < 20; i++) {
       double x = rnd.nextDouble()* (screenSize.width - tileSize);
       double y =rnd.nextDouble()* (screenSize.height - tileSize);
       flies.add(Fly(this, x, y));
     }

  }

  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff576574);
   canvas.drawRect(bgRect, bgPaint);

    flies.forEach((Fly fly) => fly.render(canvas));
  }

  void update(double t) {
    flies.forEach((Fly fly) => fly.update(t));
    flies.removeWhere((Fly fly) => fly.isOffScreen);

  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;

  }

  void onTapDown(TapDownDetails d) {
    flies.forEach((Fly fly) {
      if (fly.flyRect.contains(d.globalPosition)) {
        fly.onTapDown();
      }
    });
  }

}
