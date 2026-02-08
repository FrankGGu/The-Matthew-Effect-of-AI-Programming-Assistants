-module(solve).
-export([subarray_sum/2]).

subarray_sum(Nums, K) ->
    Map = #{0 => 1},
    subarray_sum(Nums, K, 0, Map, 0).

subarray_sum([], _, _, _, Count) ->
    Count;
subarray_sum([H | T], K, Sum, Map, Count) ->
    NewSum = Sum + H,
    Case = maps:get(NewSum - K, Map, 0),
    NewCount = Count + Case,
    NewMap = maps:update(NewSum, maps:get(NewSum, Map, 0) + 1, Map),
    subarray_sum(T, K, NewSum, NewMap, NewCount).