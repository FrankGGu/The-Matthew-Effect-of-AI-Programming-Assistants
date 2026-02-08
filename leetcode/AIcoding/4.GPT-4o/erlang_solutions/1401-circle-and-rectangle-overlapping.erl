-module(solution).
-export([checkOverlap/4]).

checkOverlap(Cx, Cy, R, x1, y1, x2, y2) ->
    RectCenterX = (x1 + x2) / 2,
    RectCenterY = (y1 + y2) / 2,
    RectWidth = abs(x2 - x1),
    RectHeight = abs(y2 - y1),
    HalfWidth = RectWidth / 2,
    HalfHeight = RectHeight / 2,
    ClosestX = max(x1, min(Cx, x2)),
    ClosestY = max(y1, min(Cy, y2)),
    DistX = ClosestX - Cx,
    DistY = ClosestY - Cy,
    DistX * DistX + DistY * DistY < R * R.