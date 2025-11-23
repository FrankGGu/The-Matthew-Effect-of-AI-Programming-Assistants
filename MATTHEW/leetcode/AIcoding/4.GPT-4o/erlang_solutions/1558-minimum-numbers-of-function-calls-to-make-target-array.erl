-module(solution).
-export([min_operations/1]).

min_operations(Array) ->
    Max = lists:max(Array),
    Count = lists:foldl(fun(X, Acc) -> Acc + (X div 2) end, 0, Array) + length(Array),
    Max + Count.