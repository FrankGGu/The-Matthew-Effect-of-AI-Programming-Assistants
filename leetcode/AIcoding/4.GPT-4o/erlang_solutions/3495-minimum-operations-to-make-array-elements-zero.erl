-module(solution).
-export([minimum_operations/1]).

minimum_operations(A) ->
    Min = lists:min(A),
    lists:foldl(fun(X, Acc) -> Acc + (X - Min) div Min end, 0, A).