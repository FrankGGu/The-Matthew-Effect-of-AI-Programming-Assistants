-spec str_str(Haystack :: unicode:unicode_binary(), Needle :: unicode:unicode_binary()) -> integer().
str_str(Haystack, Needle) ->
    case lists:prefix(Needle, Haystack) of
        true -> 0;
        false -> find_index(Haystack, Needle, 0)
    end.

find_index([], _, _) -> -1;
find_index([_ | Tail], Needle, Index) ->
    case lists:prefix(Needle, Tail) of
        true -> Index + 1;
        false -> find_index(Tail, Needle, Index + 1)
    end.
