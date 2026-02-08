-spec append_characters(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> integer().
append_characters(S, T) ->
    append_chars(binary_to_list(S), binary_to_list(T), 0).

append_chars(_, [], Count) ->
    Count;
append_chars([], [_ | RestT], Count) ->
    Count + 1 + length(RestT);
append_chars([H | RestS], [H | RestT], Count) ->
    append_chars(RestS, RestT, Count);
append_chars([_ | RestS], T, Count) ->
    append_chars(RestS, T, Count).