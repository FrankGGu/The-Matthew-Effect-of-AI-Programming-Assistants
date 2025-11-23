-module(binary_subarrays_with_sum).
-export([numSubarraysWithSum/2]).

numSubarraysWithSum(Nums, k) ->
    Map = maps:new(),
    maps:put(0, 1, Map),
    Count = 0,
    Sum = 0,
    numSubarraysWithSum(Nums, k, Map, Count, Sum).

numSubarraysWithSum([], _, _, Count, _) ->
    Count;
numSubarraysWithSum([H | T], K, Map, Count, Sum) ->
    NewSum = Sum + H,
    Prev = maps:get(NewSum - K, Map, 0),
    NewCount = Count + Prev,
    NewMap = maps:put(NewSum, maps:get(NewSum, Map, 0) + 1, Map),
    numSubarraysWithSum(T, K, NewMap, NewCount, NewSum).