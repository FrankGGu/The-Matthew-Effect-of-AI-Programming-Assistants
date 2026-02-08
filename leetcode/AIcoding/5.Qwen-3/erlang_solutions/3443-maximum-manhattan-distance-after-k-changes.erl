-module(max_manhattan_distance_after_k_changes).
-export([maxDistance/2]).

maxDistance(Points, K) ->
    lists:foldl(fun(P, Acc) -> max(Acc, manhattan(P)) end, 0, Points).

manhattan({X1, Y1, X2, Y2}) ->
    abs(X1 - X2) + abs(Y1 - Y2).