-spec min_window(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> unicode:unicode_binary().
min_window(S, T) ->
    min_window(S, T, 0, 0, <<>>, map:new()).

min_window(<<>>, _, _, _, Acc, _) -> Acc;
min_window(_, _, _, _, Acc, CountMap) when map_size(CountMap) =:= 0 -> Acc;
min_window(<<SChar:8, Rest/binary>>, T, Left, Right, Acc, CountMap) ->
    NewCountMap = update_count_map(SChar, CountMap),
    NewLeft = Left + 1,
    case satisfies_all_chars(NewCountMap, T) of
        true -> 
            min_window(Rest, T, NewLeft, Right + 1, <<SChar:8/binary, Acc/binary>>, NewCountMap);
        false ->
            min_window(Rest, T, Left, Right + 1, Acc, NewCountMap)
    end.

update_count_map(Char, Map) ->
    case map:find(Char, Map) of
        {ok, Count} -> map:put(Char, Count + 1, Map);
        _ -> map:put(Char, 1, Map)
    end.

satisfies_all_chars(Map, T) ->
    lists:all(fun(Char) -> map:find(Char, Map) =:= {ok, _} end, T).
