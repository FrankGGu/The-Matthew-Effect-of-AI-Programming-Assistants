-spec balanced_string_split(S :: unicode:unicode_binary()) -> integer().
balanced_string_split(S) ->
    balanced_string_split(S, 0, 0, 0).

balanced_string_split(<<>>, Count, _, _) ->
    Count;
balanced_string_split(<<$R, Rest/binary>>, Count, R, L) ->
    balanced_string_split(Rest, Count, R + 1, L);
balanced_string_split(<<$L, Rest/binary>>, Count, R, L) ->
    balanced_string_split(Rest, Count, R, L + 1);
balanced_string_split(_, Count, R, L) when R =:= L ->
    balanced_string_split(<<>>, Count + 1, 0, 0);
balanced_string_split(Rest, Count, R, L) ->
    balanced_string_split(Rest, Count, R, L).