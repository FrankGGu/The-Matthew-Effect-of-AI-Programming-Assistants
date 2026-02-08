-module(solution).
-export([num_subarrays/1]).

num_subarrays(Nums) ->
    Count = 0,
    Map = maps:new(),
    Map2 = maps:put(0, 1, Map),
    CurrentSum = 0,
    num_subarrays(Nums, CurrentSum, Map2, Count).

num_subarrays([], _, _, Count) ->
    Count;
num_subarrays([H | T], CurrentSum, Map, Count) ->
    CurrentSum2 = CurrentSum + H,
    Key = CurrentSum2 rem 3,
    Value = maps:get(Key, Map, 0),
    Count2 = Count + Value,
    Map2 = maps:put(Key, Value + 1, Map),
    num_subarrays(T, CurrentSum2, Map2, Count2).