-module(dna_pattern_recognition).
-export([find_repeated_dna/1]).

find_repeated_dna(S) ->
    Length = length(S),
    if
        Length < 10 -> [];
        true ->
            Map = maps:new(),
            find_repeated_dna(S, 0, Length, Map, [])
    end.

find_repeated_dna(_, _, Length, _, Acc) when Length - 10 + 1 < 0 -> lists:reverse(Acc);
find_repeated_dna(S, Start, Length, Map, Acc) ->
    End = Start + 9,
    Sub = lists:sublist(S, Start + 1, 10),
    Count = maps:get(Sub, Map, 0),
    NewMap = maps:put(Sub, Count + 1, Map),
    case Count of
        0 -> find_repeated_dna(S, Start + 1, Length, NewMap, Acc);
        _ -> find_repeated_dna(S, Start + 1, Length, NewMap, [Sub | Acc])
    end.