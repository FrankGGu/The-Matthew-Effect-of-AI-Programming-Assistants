-module(solution).
-export([reduce_operations/1]).

reduce_operations(A) ->
    Count = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), A),
    SortedKeys = lists:reverse(lists:sort(maps:keys(Count))),
    Total = lists:foldl(fun(Key, {Acc, Cnt}) -> {Acc + (Cnt * (maps:get(Key, Count) - 1)), Cnt + 1} end, {0, 0}, SortedKeys),
    element(1, Total).