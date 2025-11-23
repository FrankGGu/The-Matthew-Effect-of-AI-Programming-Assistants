-spec can_make_subsequence(Str1 :: unicode:unicode_binary(), Str2 :: unicode:unicode_binary()) -> boolean().
can_make_subsequence(Str1, Str2) ->
    can_make_subsequence(Str1, Str2, 0, 0).

can_make_subsequence(_, _, Len2, Len2) -> true;
can_make_subsequence(<<>>, _, _, _) -> false;
can_make_subsequence(<<C1:8, Rest1/binary>>, <<C2:8, Rest2/binary>>, I, J) ->
    case (C1 =:= C2) orelse ((C1 rem 26 + 1) rem 26 =:= C2 rem 26) of
        true -> can_make_subsequence(Rest1, Rest2, I + 1, J + 1);
        false -> can_make_subsequence(Rest1, <<C2:8, Rest2/binary>>, I + 1, J)
    end;
can_make_subsequence(<<_:8, Rest1/binary>>, Str2, I, J) ->
    can_make_subsequence(Rest1, Str2, I + 1, J).