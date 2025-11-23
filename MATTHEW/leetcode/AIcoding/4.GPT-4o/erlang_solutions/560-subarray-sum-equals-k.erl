-module(solution).
-export([subarray_sum_equals_k/2]).

subarray_sum_equals_k(Array, K) ->
    subarray_sum_equals_k(Array, K, 0, #{0 => 1}, 0).

subarray_sum_equals_k([], _, _, _, Count) ->
    Count;
subarray_sum_equals_k([H | T], K, Sum, Map, Count) ->
    NewSum = Sum + H,
    NewCount = maps:get(NewSum - K, Map, 0) + Count,
    NewMap = maps:update(NewSum, fun(X) -> X + 1 end, 1, Map),
    subarray_sum_equals_k(T, K, NewSum, NewMap, NewCount).