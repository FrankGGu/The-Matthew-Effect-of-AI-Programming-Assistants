-module(maximum_sum_circular_subarray).
-export([maxSubarraySumCircular/1]).

maxSubarraySumCircular(Nums) ->
    MaxSubarraySum = maxSubarraySum(Nums),
    MinSubarraySum = minSubarraySum(Nums),
    TotalSum = lists:sum(Nums),
    if
        MaxSubarraySum < 0 ->
            MaxSubarraySum;
        true ->
            erlang:max(MaxSubarraySum, TotalSum - MinSubarraySum)
    end.

maxSubarraySum(Nums) ->
    CurrentMax = 0,
    MaxSoFar = 0,
    lists:foldl(fun(X, Acc) ->
        CurrentMax = erlang:max(X, CurrentMax + X),
        MaxSoFar = erlang:max(MaxSoFar, CurrentMax),
        {CurrentMax, MaxSoFar}
    end, {0, 0}, Nums).

minSubarraySum(Nums) ->
    CurrentMin = 0,
    MinSoFar = 0,
    lists:foldl(fun(X, Acc) ->
        CurrentMin = erlang:min(X, CurrentMin + X),
        MinSoFar = erlang:min(MinSoFar, CurrentMin),
        {CurrentMin, MinSoFar}
    end, {0, 0}, Nums).