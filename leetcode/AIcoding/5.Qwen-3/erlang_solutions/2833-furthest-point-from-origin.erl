-module(furthest_point_from_origin).
-export([max_distance/1]).

max_distance({X, Y}) ->
    max_distance(X, Y).

max_distance(X, Y) ->
    XAbs = abs(X),
    YAbs = abs(Y),
    Max = max(XAbs, YAbs),
    Max * 2.