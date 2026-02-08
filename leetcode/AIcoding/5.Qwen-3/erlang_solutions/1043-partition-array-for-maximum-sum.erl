-module(partition_array_for_max_sum).
-export([maxSumAfterPartition/2]).

maxSumAfterPartition(Arr, K) ->
    N = length(Arr),
    DP = array:new(N, {default, 0}),
    maxSumAfterPartition(Arr, K, DP, 0).

maxSumAfterPartition(_, _, _, N) ->
    array:get(N, DP);
maxSumAfterPartition(Arr, K, DP, I) ->
    MaxVal = get_max_val(Arr, I, min(I + K, length(Arr))),
    NewDP = array:set(I, lists:max([array:get(J, DP) + MaxVal * (J - I) || J <- lists:seq(I + 1, min(I + K, length(Arr))) ]), DP),
    maxSumAfterPartition(Arr, K, NewDP, I + 1).

get_max_val(Arr, I, J) ->
    lists:max(lists:sublist(Arr, I + 1, J - I)).