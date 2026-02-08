-module(solution).
-export([divide_array_into_arrays_with_max_difference/2]).

divide_array_into_arrays_with_max_difference(Nums, K) ->
    SortedNums = lists:sort(Nums),
    divide_array_recursive(SortedNums, K, []).

divide_array_recursive([], _K, Acc) ->
    lists:reverse(Acc);
divide_array_recursive([A, B, C | Rest], K, Acc) ->
    if
        C - A =< K ->
            divide_array_recursive(Rest, K, [[A, B, C] | Acc]);
        true ->
            []
    end.