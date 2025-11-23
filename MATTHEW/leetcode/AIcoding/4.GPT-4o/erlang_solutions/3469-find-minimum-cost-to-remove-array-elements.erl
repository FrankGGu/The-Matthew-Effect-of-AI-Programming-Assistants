-module(solution).
-export([min_cost/1]).

min_cost(A) ->
    Counts = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(Val) -> Val + 1 end, 1, Acc) end, #{}, A),
    MaxCount = maps:fold(fun(_, V, Acc) -> max(V, Acc) end, 0, Counts),
    Total = length(A),
    Total - MaxCount.