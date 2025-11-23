-module(max_min_subarray_sum).
-export([maxMinSubarraySum/2]).

maxMinSubarraySum(Arr, K) ->
    N = length(Arr),
    Min = lists:foldl(fun(I, Acc) -> min(Acc, lists:sublist(Arr, I, K)) end, 1000000, lists:seq(1, N - K + 1)),
    Max = lists:foldl(fun(I, Acc) -> max(Acc, lists:sublist(Arr, I, K)) end, -1000000, lists:seq(1, N - K + 1)),
    {Max, Min}.