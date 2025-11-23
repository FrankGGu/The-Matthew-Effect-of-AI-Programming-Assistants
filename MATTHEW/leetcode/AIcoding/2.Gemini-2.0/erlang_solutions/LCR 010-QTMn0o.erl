-module(subarray_sum_k).
-export([subarray_sum/2]).

subarray_sum(Nums, K) ->
    subarray_sum(Nums, K, 0, 0, #{0 => 1}).

subarray_sum([], _, _, Count, _) ->
    Count;
subarray_sum([H|T], K, Sum, Count, PrefixSums) ->
    NewSum = Sum + H,
    NewCount = maps:get(NewSum - K, PrefixSums, 0) + Count,
    NewPrefixSums = maps:update_with(NewSum, fun(V) -> V + 1 end, 1, PrefixSums),
    subarray_sum(T, K, NewSum, NewCount, NewPrefixSums).