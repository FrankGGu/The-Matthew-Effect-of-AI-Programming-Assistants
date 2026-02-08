-module(solution).
-export([max_size_after_removals/2]).

max_size_after_removals(Nums, M) ->
    Count = lists:foldl(fun(N, Acc) -> dict:update_counter(N, 1, Acc) end, dict:new(), Nums),
    Counts = dict:to_list(Count),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A >= B end, Counts),
    Max = length(Nums) - M,
    Result = 0,
    process(Sorted, M, 0, Result).

process([], _, _, Acc) ->
    Acc;
process([{_Val, 1} | T], M, _Used, Acc) ->
    process(T, M - 1, 0, Acc + 1);
process([{_Val, C} | T], M, Used, Acc) ->
    if
        M > 0 ->
            process(T, M - 1, 0, Acc + 1);
        true ->
            process(T, M, 1, Acc + (C - 1))
    end.