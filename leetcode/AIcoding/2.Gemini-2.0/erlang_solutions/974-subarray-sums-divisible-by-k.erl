-module(subarray_sums_divisible_by_k).
-export([subarray_sums_divisible_by_k/2]).

subarray_sums_divisible_by_k(A, K) ->
    subarray_sums_divisible_by_k(A, K, 0, 0, lists:foldl(fun(_, Acc) -> Acc ++ [0] end, [], lists:seq(1, K))).

subarray_sums_divisible_by_k([], _, _, Count, Freq) ->
    Count;
subarray_sums_divisible_by_k([H|T], K, Sum, Count, Freq) ->
    NewSum = (Sum + H) rem K,
    NewSumNormalized = if NewSum < 0 -> NewSum + K; true -> NewSum end,
    NewCount = Count + lists:nth(NewSumNormalized + 1, Freq),
    NewFreq = lists:update_at(NewSumNormalized + 1, Freq, lists:nth(NewSumNormalized + 1, Freq) + 1),
    subarray_sums_divisible_by_k(T, K, NewSum, NewCount, NewFreq).