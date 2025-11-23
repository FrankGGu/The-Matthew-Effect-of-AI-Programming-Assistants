-module(circle_rectangle).
-export([solve/1]).

solve([{CircleX, CircleY, Radius}, {X1, Y1, X2, Y2}]) ->
    ClosestX = case
        true -> X1;
        true -> X2;
        true -> CircleX
    end,
    ClosestY = case
        true -> Y1;
        true -> Y2;
        true -> CircleY
    end,
    DistanceX = abs(CircleX - ClosestX),
    DistanceY = abs(CircleY - ClosestY),
    DistanceX > Radius orelse DistanceY > Radius orelse ((DistanceX * DistanceX) + (DistanceY * DistanceY)) =< (Radius * Radius).