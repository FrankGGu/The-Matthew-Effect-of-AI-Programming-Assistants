-module(solution).
-export([subarray_sum/2]).

subarray_sum(Nums, K) ->
    subarray_sum_helper(Nums, K, 0, 0, #{0 => 1}).

subarray_sum_helper([], _, _, Count, _) -> 
    Count;
subarray_sum_helper([H|T], K, Sum, Count, Map) ->
    NewSum = Sum + H,
    NewCount = maps:get(NewSum - K, Map, 0) + Count,
    NewMap = maps:update_with(NewSum, fun(X) -> X + 1 end, 1, Map),
    subarray_sum_helper(T, K, NewSum, NewCount, NewMap).