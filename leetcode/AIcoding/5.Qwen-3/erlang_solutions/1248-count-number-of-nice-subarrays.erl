-module(solution).
-export([nice_subarrays/1]).

nice_subarrays(Nums) ->
    Count = 0,
    Prefix = 0,
    Map = #{0 => 1},
    lists:foldl(fun(N, {CountAcc, PrefixAcc, MapAcc}) ->
        NewPrefix = PrefixAcc + (N rem 2),
        Case = maps:get(NewPrefix, MapAcc, 0),
        {CountAcc + Case, NewPrefix, maps:update(NewPrefix, Case + 1, MapAcc)}
    end, {Count, Prefix, Map}, Nums).

nice_subarrays(Nums) ->
    nice_subarrays(Nums, 0, 0, #{0 => 1}).

nice_subarrays([], Count, _Prefix, _Map) ->
    Count;
nice_subarrays([H | T], Count, Prefix, Map) ->
    NewPrefix = Prefix + (H rem 2),
    Case = maps:get(NewPrefix, Map, 0),
    NewCount = Count + Case,
    NewMap = maps:update(NewPrefix, Case + 1, Map),
    nice_subarrays(T, NewCount, NewPrefix, NewMap).