-module(solution).
-export([maximum_distinct_after_operations/2]).

maximum_distinct_after_operations(Nums, K) ->
    Count = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), Nums),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A < B end, maps:to_list(Count)),
    process(Sorted, K).

process([], _) ->
    0;
process([{_Val, 1} | T], K) ->
    1 + process(T, K);
process([{_Val, Count} | T], K) ->
    if
        Count - 1 =< K ->
            process(T, K - (Count - 1));
        true ->
            1 + process(T, K)
    end.