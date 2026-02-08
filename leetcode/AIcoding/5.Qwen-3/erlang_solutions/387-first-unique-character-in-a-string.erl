-module(first_unique_character_in_a_string).
-export([firstUniqChar/1]).

firstUniqChar(Str) ->
    Map = build_map(Str, 0, #{}),
    find_first_unique(Str, Map, 0).

build_map([], _, Acc) ->
    Acc;
build_map([H | T], Index, Acc) ->
    Count = maps:get(H, Acc, 0),
    build_map(T, Index + 1, maps:put(H, Count + 1, Acc)).

find_first_unique([], _, _) ->
    -1;
find_first_unique([H | T], Map, Index) ->
    case maps:get(H, Map, 0) of
        1 -> Index;
        _ -> find_first_unique(T, Map, Index + 1)
    end.