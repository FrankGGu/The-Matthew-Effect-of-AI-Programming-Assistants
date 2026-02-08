-module(solution).
-export([min_operations/2]).

min_operations(Array, K) ->
    lists:foldl(fun(X, Acc) -> Acc + abs(X - K) end, 0, Array).