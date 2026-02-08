-module(find_subarray_bitwise_or_closest_to_k).
-export([find_closest_subarray/2]).

find_closest_subarray(Nums, K) ->
    find_closest_subarray(Nums, K, 0, length(Nums) - 1).

find_closest_subarray(Nums, K, L, R) ->
    case L > R of
        true ->
            infinity;
        false ->
            find_closest_subarray_helper(Nums, K, L, R, infinity)
    end.

find_closest_subarray_helper(Nums, K, L, R, MinDiff) ->
    case L > R of
        true ->
            MinDiff;
        false ->
            OrVal = lists:foldl(fun(I, Acc) -> Acc bor lists:nth(I + 1, Nums) end, 0, lists:seq(L, R)),
            Diff = abs(OrVal - K),
            NewMinDiff = min(MinDiff, Diff),
            find_closest_subarray_helper(Nums, K, L + 1, R, NewMinDiff)
    end.

min(A, B) ->
    if A < B ->
        A;
    true ->
        B
    end.

infinity -> 1000000000.