-module(solution).
-export([minimizeManhattanDistances/2]).

minimizeManhattanDistances(Xs, Ys) ->
    XsSorted = lists:sort(Xs),
    YsSorted = lists:sort(Ys),
    lists:foldl(fun({X, Y}, Acc) -> Acc + abs(X - Y) end, 0, lists:zip(XsSorted, YsSorted).