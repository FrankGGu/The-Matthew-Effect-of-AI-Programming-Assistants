-spec length_of_longest_substring(S :: unicode:unicode_binary()) -> integer().
length_of_longest_substring(S) ->
    length_of_longest_substring(S, 0, 0, #{}).

length_of_longest_substring(<<C/utf8, Rest/binary>>, Start, Max, Map) ->
    case maps:find(C, Map) of
        {ok, Index} when Index >= Start ->
            NewStart = Index + 1,
            length_of_longest_substring(Rest, NewStart, max(Max, Index - Start + 1), maps:put(C, Start, Map));
        _ ->
            length_of_longest_substring(Rest, Start, max(Max, Start - maps:get(C, Map, Start) + 1), maps:put(C, Start, Map))
    end;
length_of_longest_substring(<<>>, _Start, Max, _Map) ->
    Max.