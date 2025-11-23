-module(two_sum).
-export([new/2, add/3, count/2]).

new(Nums1, Nums2) ->
    Nums2Map = list_to_map_indexed(Nums2),
    Freq2Map = build_freq_map(Nums2),
    #{nums1 => Nums1, nums2_map => Nums2Map, freq2_map => Freq2Map}.

add(State, Index, Val) ->
    Nums2Map = maps:get(nums2_map, State),
    Freq2Map = maps:get(freq2_map, State),

    OldVal = maps:get(Index, Nums2Map),

    NewFreq2Map1 = update_freq_map_decrement(Freq2Map, OldVal),
    NewFreq2Map2 = update_freq_map_increment(NewFreq2Map1, Val),

    NewNums2Map = maps:put(Index, Val, Nums2Map),

    State#{nums2_map => NewNums2Map, freq2_map => NewFreq2Map2}.

count(State, Val) ->
    Nums1 = maps:get(nums1, State),
    Freq2Map = maps:get(freq2_map, State),

    lists:foldl(fun(N1, Acc) ->
        Target = Val - N1,
        Acc + maps:get(Target, Freq2Map, 0)
    end, 0, Nums1).

list_to_map_indexed(List) ->
    list_to_map_indexed(List, 0, #{}).

list_to_map_indexed([], _Idx, Map) -> Map;
list_to_map_indexed([H|T], Idx, Map) ->
    list_to_map_indexed(T, Idx + 1, maps:put(Idx, H, Map)).

build_freq_map(List) ->
    lists:foldl(fun(E, Acc) ->
        update_freq_map_increment(Acc, E)
    end, #{}, List).

update_freq_map_increment(Map, Key) ->
    maps:update_with(Key, fun(Count) -> Count + 1 end, 1, Map).

update_freq_map_decrement(Map, Key) ->
    case maps:find(Key, Map) of
        {ok, 1} -> maps:remove(Key, Map);
        {ok, Count} -> maps:put(Key, Count - 1, Map);
        error -> Map
    end.