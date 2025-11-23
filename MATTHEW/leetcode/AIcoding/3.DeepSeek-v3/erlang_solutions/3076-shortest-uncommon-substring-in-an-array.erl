-module(solution).
-export([shortest_uncommon_substring/1]).

shortest_uncommon_substring(Strs) ->
    SubMaps = lists:map(fun(Str) -> build_substring_map(Str) end, Strs),
    GlobalMap = merge_maps(SubMaps),
    lists:map(fun(Str) -> find_shortest_unique(Str, GlobalMap) end, Strs).

build_substring_map(Str) ->
    N = length(Str),
    Map = maps:new(),
    build_substring_map(Str, 1, N, Map).

build_substring_map(Str, I, N, Map) when I > N ->
    Map;
build_substring_map(Str, I, N, Map) ->
    NewMap = build_substrings(Str, I, I, N, Map),
    build_substring_map(Str, I + 1, N, NewMap).

build_substrings(Str, I, J, N, Map) when J > N ->
    Map;
build_substrings(Str, I, J, N, Map) ->
    Sub = lists:sublist(Str, I, J - I + 1),
    NewMap = maps:update_with(Sub, fun(V) -> V + 1 end, 1, Map),
    build_substrings(Str, I, J + 1, N, NewMap).

merge_maps(Maps) ->
    lists:foldl(fun(Map, Acc) ->
        maps:fold(fun(K, V, A) ->
            maps:update_with(K, fun(Existing) -> Existing + V end, V, A)
        end, Acc, Map)
    end, maps:new(), Maps).

find_shortest_unique(Str, GlobalMap) ->
    N = length(Str),
    case find_shortest(Str, 1, N, GlobalMap) of
        not_found -> "";
        Sub -> Sub
    end.

find_shortest(Str, Len, N, GlobalMap) when Len > N ->
    not_found;
find_shortest(Str, Len, N, GlobalMap) ->
    case find_len_substrings(Str, Len, GlobalMap) of
        not_found -> find_shortest(Str, Len + 1, N, GlobalMap);
        Sub -> Sub
    end.

find_len_substrings(Str, Len, GlobalMap) ->
    find_len_substrings(Str, 1, length(Str) - Len + 1, Len, GlobalMap).

find_len_substrings(Str, I, MaxI, Len, GlobalMap) when I > MaxI ->
    not_found;
find_len_substrings(Str, I, MaxI, Len, GlobalMap) ->
    Sub = lists:sublist(Str, I, Len),
    case maps:get(Sub, GlobalMap) of
        1 -> Sub;
        _ -> find_len_substrings(Str, I + 1, MaxI, Len, GlobalMap)
    end.