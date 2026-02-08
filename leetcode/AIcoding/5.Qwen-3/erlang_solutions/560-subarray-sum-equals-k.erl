-module(subarray_sum_equals_k).
-export([subarray_sum/1]).

subarray_sum(Nums) ->
    Map = #{0 => 1},
    subarray_sum(Nums, 0, 0, Map).

subarray_sum([], _, _, _) ->
    0;
subarray_sum([H | T], Sum, Count, Map) ->
    NewSum = Sum + H,
    case maps:get(NewSum - K, Map, 0) of
        C when is_integer(C) ->
            NewCount = Count + C,
            NewMap = maps:update(NewSum, maps:get(NewSum, Map, 0) + 1, Map),
            subarray_sum(T, NewSum, NewCount, NewMap);
        _ ->
            NewMap = maps:update(NewSum, maps:get(NewSum, Map, 0) + 1, Map),
            subarray_sum(T, NewSum, Count, NewMap)
    end.