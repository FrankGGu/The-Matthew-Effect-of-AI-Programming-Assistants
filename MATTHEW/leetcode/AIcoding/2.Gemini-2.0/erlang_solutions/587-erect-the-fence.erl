-module(erect_the_fence).
-export([outerTrees/1]).

outerTrees(Points) ->
  case length(Points) < 4 of
    true -> Points;
    false ->
      SortedPoints = lists:keysort(1, Points),
      LowerHull = buildHull(SortedPoints, fun(P1, P2, P3) -> crossProduct(P1, P2, P3) >= 0 end, []),
      UpperHull = buildHull(lists:reverse(SortedPoints), fun(P1, P2, P3) -> crossProduct(P1, P2, P3) >= 0 end, []),
      UniquePoints = lists:usort(LowerHull ++ UpperHull),
      UniquePoints
  end.

buildHull([], _, Acc) ->
  Acc;
buildHull([Point | Rest], CrossProductFun, Acc) ->
  buildHull(Rest, CrossProductFun, addPointToHull(Point, Acc, CrossProductFun)).

addPointToHull(Point, [], _) ->
  [Point];
addPointToHull(Point, [P1], _) ->
  [P1, Point];
addPointToHull(Point, [P1, P2 | Rest], CrossProductFun) ->
  case CrossProductFun(P1, P2, Point) of
    true ->
      [P1, P2 | Rest, Point];
    false ->
      addPointToHull(Point, [P1 | Rest], CrossProductFun)
  end.

crossProduct([X1, Y1], [X2, Y2], [X3, Y3]) ->
  (X2 - X1) * (Y3 - Y1) - (Y2 - Y1) * (X3 - X1).