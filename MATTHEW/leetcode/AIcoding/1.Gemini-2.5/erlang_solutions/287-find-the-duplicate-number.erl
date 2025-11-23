-module(solution).
-export([findDuplicate/1]).

findDuplicate(Nums) ->
    N = length(Nums) - 1,
    Low = 1,
    High = N,
    binary_search(Low, High, Nums).

binary_search(Low, High, Nums) when Low < High ->
    Mid = Low + (High - Low) div 2,
    Count = count_less_equal(Nums, Mid),
    if
        Count > Mid ->
            binary_search(Low, Mid, Nums);
        true ->
            binary_search(Mid + 1, High, Nums)
    end;
binary_search(Low, High, _Nums) when Low =:= High ->
    Low.

count_less_equal(List, Value) ->
    lists:foldl(fun(X, Acc) ->
        if
            X =< Value -> Acc + 1;
            true -> Acc
        end
    end, 0, List).