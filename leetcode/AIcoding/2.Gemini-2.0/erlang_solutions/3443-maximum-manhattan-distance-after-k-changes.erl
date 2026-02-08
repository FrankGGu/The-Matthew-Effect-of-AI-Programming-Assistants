-module(max_manhattan).
-export([solve/1]).

solve(Points) ->
  K = element(2, hd(Points)),
  PointsWithoutK = tl(Points),
  MaxA = lists:foldl(fun({X, Y}, Acc) -> max(Acc, X + Y) end, -infinity, PointsWithoutK),
  MinA = lists:foldl(fun({X, Y}, Acc) -> min(Acc, X + Y) end, infinity, PointsWithoutK),
  MaxB = lists:foldl(fun({X, Y}, Acc) -> max(Acc, X - Y) end, -infinity, PointsWithoutK),
  MinB = lists:foldl(fun({X, Y}, Acc) -> min(Acc, X - Y) end, infinity, PointsWithoutK),
  MaxC = lists:foldl(fun({X, Y}, Acc) -> max(Acc, -X + Y) end, -infinity, PointsWithoutK),
  MinC = lists:foldl(fun({X, Y}, Acc) -> min(Acc, -X + Y) end, infinity, PointsWithoutK),
  MaxD = lists:foldl(fun({X, Y}, Acc) -> max(Acc, -X - Y) end, -infinity, PointsWithoutK),
  MinD = lists:foldl(fun({X, Y}, Acc) -> min(Acc, -X - Y) end, infinity, PointsWithoutK),
  max([MaxA - MinA, MaxB - MinB, MaxC - MinC, MaxD - MinD]) + K.