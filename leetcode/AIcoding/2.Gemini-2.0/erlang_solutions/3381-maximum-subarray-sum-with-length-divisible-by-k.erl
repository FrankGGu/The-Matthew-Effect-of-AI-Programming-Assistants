-module(maximum_subarray_sum_divisible_by_k).
-export([max_subarray_sum_divisible_by_k/2]).

max_subarray_sum_divisible_by_k(Nums, K) ->
    max_subarray_sum_divisible_by_k(Nums, K, 0, 0, lists:duplicate(K, -1000000000)).

max_subarray_sum_divisible_by_k([], _K, _CurrentSum, MaxSum, _RemSums) ->
    MaxSum;
max_subarray_sum_divisible_by_k([Num | Rest], K, CurrentSum, MaxSum, RemSums) ->
    NewSum = CurrentSum + Num,
    Rem = NewSum rem K,
    RemFixed = if Rem < 0 -> Rem + K; true -> Rem end,
    NewMaxSum = max(MaxSum, NewSum - lists:nth(RemFixed + 1, RemSums)),
    NewRemSums = lists:nth(RemFixed + 1, RemSums) == -1000000000
                 andalso RemSums:lists.replace_nth(RemFixed, NewSum, RemSums)
                 orelse RemSums,
    max_subarray_sum_divisible_by_k(Rest, K, NewSum, NewMaxSum, NewRemSums).

max(A, B) ->
    if A > B -> A; true -> B end.