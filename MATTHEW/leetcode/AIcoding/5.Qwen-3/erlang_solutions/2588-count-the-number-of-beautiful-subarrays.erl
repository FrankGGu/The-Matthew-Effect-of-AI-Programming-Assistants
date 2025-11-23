-module(solution).
-export([beautiful_subarrays/1]).

beautiful_subarrays(Rows) ->
    Count = 0,
    PrefixXOR = 0,
    Map = #{},
    Map1 = maps:put(PrefixXOR, 1, Map),
    beautiful_subarrays(Rows, PrefixXOR, Map1, Count).

beautiful_subarrays([], _, _, Count) ->
    Count;

beautiful_subarrays([Row | Rows], PrefixXOR, Map, Count) ->
    NewPrefixXOR = PrefixXOR bxor Row,
    CurrentCount = maps:get(NewPrefixXOR, Map, 0),
    NewCount = Count + CurrentCount,
    NewMap = maps:update(NewPrefixXOR, CurrentCount + 1, Map),
    beautiful_subarrays(Rows, NewPrefixXOR, NewMap, NewCount).