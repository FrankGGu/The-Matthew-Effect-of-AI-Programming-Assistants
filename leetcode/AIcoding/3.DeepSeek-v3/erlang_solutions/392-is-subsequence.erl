-spec is_subsequence(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> boolean().
is_subsequence(S, T) ->
    is_subsequence(S, T, 0, 0).

is_subsequence(<<>>, _, _, _) -> true;
is_subsequence(_, <<>>, _, _) -> false;
is_subsequence(<<C1, RestS/binary>>, <<C2, RestT/binary>>, I, J) when C1 =:= C2 ->
    is_subsequence(RestS, RestT, I + 1, J + 1);
is_subsequence(S, <<_, RestT/binary>>, I, J) ->
    is_subsequence(S, RestT, I, J + 1).