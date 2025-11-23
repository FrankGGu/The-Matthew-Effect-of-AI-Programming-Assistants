-spec is_interleave(S1 :: unicode:unicode_binary(), S2 :: unicode:unicode_binary(), S3 :: unicode:unicode_binary()) -> boolean().
is_interleave(S1, S2, S3) ->
    is_interleave(S1, S2, S3, []).

is_interleave(_, _, [], _) -> true;
is_interleave([], [], _) -> false;
is_interleave([H1 | T1], [H2 | T2], [H3 | T3]) when H1 =:= H3 ->
    is_interleave(T1, [H2 | T2], T3);
is_interleave([H1 | T1], [H2 | T2], [H3 | T3]) when H2 =:= H3 ->
    is_interleave([H1 | T1], T2, T3);
is_interleave(_, _, _, _) -> false.
