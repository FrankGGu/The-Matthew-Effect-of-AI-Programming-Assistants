-module(solution).
-export([maxDistance/1]).

maxDistance(Points) ->
    lists:foldl(fun(Point, Acc) -> max(Acc, distance(Point)) end, 0, Points).

distance({X, Y}) ->
    X + Y.