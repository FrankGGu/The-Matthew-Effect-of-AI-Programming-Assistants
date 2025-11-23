-module(solution).
-export([subarray_sum_divisible_by_k/2]).

subarray_sum_divisible_by_k(Nums, K) ->
    Sums = lists:map(fun(X) -> sum_subarrays(X, Nums, K, 0, 0, 0) end, lists:seq(1, length(Nums))),
    lists:sum(Sums).

sum_subarrays(_, [], _, _, Count, _) -> Count;
sum_subarrays(Index, [H | T], K, CurrentSum, Count, Mod) ->
    NewSum = CurrentSum + H,
    NewMod = (NewSum rem K + K) rem K,
    NewCount = Count + (if NewMod =:= 0 -> 1; true -> 0 end),
    sum_subarrays(Index + 1, T, K, NewSum, NewCount, NewMod).