-module(partition_array_for_maximum_sum).
-export([max_sum_after_partitioning/2]).

max_sum_after_partitioning(Arr, K) ->
    N = length(Arr),
    max_sum_after_partitioning_helper(Arr, K, N).

max_sum_after_partitioning_helper(Arr, K, N) ->
    memo(Arr, K, N, array:new(N, [{default, -1}])).

memo(Arr, K, N, DP) ->
    memo(0, Arr, K, N, DP).

memo(I, Arr, K, N, DP) ->
    case array:get(I, DP) of
        {default, -1} ->
            Result = calculate_memo(I, Arr, K, N, DP),
            DP2 = array:set(I, Result, DP),
            Result;
        Value ->
            Value
    end.

calculate_memo(I, Arr, K, N, DP) ->
    if
        I == N ->
            0;
        true ->
            MaxSum = lists:foldl(
                fun(J, Acc) ->
                    Len = J - I + 1,
                    MaxVal = lists:max(lists:sublist(Arr, I + 1, Len)),
                    NextSum = memo(J + 1, Arr, K, N, DP),
                    max(Acc, MaxVal * Len + NextSum)
                end,
                0,
                lists:seq(I, min(N - 1, I + K - 1))
            ),
            MaxSum
    end.