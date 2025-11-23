-spec close_strings(Word1 :: unicode:unicode_binary(), Word2 :: unicode:unicode_binary()) -> boolean().
close_strings(Word1, Word2) ->
    L1 = length(Word1),
    L2 = length(Word2),
    if
        L1 =/= L2 -> false;
        true ->
            Freq1 = lists:sort(maps:values(frequency_map(Word1))),
            Freq2 = lists:sort(maps:values(frequency_map(Word2))),
            Keys1 = lists:sort(maps:keys(frequency_map(Word1))),
            Keys2 = lists:sort(maps:keys(frequency_map(Word2))),
            Freq1 =:= Freq2 andalso Keys1 =:= Keys2
    end.

frequency_map(Word) ->
    frequency_map(Word, #{}).

frequency_map(<<>>, Map) -> Map;
frequency_map(<<C, Rest/binary>>, Map) ->
    case maps:get(C, Map, undefined) of
        undefined -> frequency_map(Rest, Map#{C => 1});
        Count -> frequency_map(Rest, Map#{C => Count + 1})
    end.