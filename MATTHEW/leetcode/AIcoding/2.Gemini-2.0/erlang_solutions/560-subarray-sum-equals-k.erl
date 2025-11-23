-module(subarray_sum_equals_k).
-export([subarraySum/2]).

subarraySum(Nums, K) ->
    subarraySum(Nums, K, 0, #{0 => 1}, 0).

subarraySum([], _, _, _, Count) ->
    Count;
subarraySum([Num|Rest], K, Sum, SumMap, Count) ->
    NewSum = Sum + Num,
    NewCount = case maps:is_key(SumMap, NewSum - K) of
        true -> Count + maps:get(SumMap, NewSum - K);
        false -> Count
    end,
    NewSumMap = maps:update_with(NewSum, fun(V) -> V + 1 end, 1, SumMap),
    subarraySum(Rest, K, NewSum, NewSumMap, NewCount).