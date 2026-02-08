-spec max_len_substring(S :: unicode:unicode_binary()) -> integer().
max_len_substring(S) ->
    Bin = unicode:characters_to_binary(S),
    max_len_substring(Bin, 0, 0, #{}).

max_len_substring(<<>>, Start, Max, _Map) ->
    Max;
max_len_substring(<<C/utf8, Rest/binary>>, Start, Max, Map) ->
    case maps:get(C, Map, undefined) of
        undefined ->
            NewMap = maps:put(C, Start, Map),
            max_len_substring(Rest, Start + 1, Max, NewMap);
        Pos when Pos >= Start ->
            max_len_substring(Rest, Pos + 1, Max, Map);
        Pos ->
            NewMap = maps:put(C, Start, Map),
            CurrentLen = Start - Pos,
            NewMax = max(Max, CurrentLen),
            max_len_substring(Rest, Start + 1, NewMax, NewMap)
    end.