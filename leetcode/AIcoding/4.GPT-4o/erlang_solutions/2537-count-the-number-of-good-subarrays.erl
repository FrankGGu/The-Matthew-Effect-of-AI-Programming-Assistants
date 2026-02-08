-module(solution).
-export([count_good_subarrays/1]).

count_good_subarrays(Nums) ->
    N = length(Nums),
    Map = maps:from_list([{0, 1}]),
    count_good_subarrays(Nums, 0, 0, Map).

count_good_subarrays([], _, Count, Map) ->
    Count;
count_good_subarrays([H | T], K, Count, Map) ->
    NewK = K + H,
    NewCount = maps:get(NewK, Map, 0),
    UpdatedMap = maps:update(NewK, NewCount + 1, Map),
    count_good_subarrays(T, NewK, Count + NewCount, UpdatedMap).