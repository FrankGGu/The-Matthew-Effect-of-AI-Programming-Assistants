-spec is_match(S :: unicode:unicode_binary(), P :: unicode:unicode_binary()) -> boolean().
is_match([], []) -> true;
is_match([H | T], [H | PTail]) -> is_match(T, PTail);
is_match([H | T], [$. | PTail]) -> is_match(T, PTail);
is_match(S, [H, $* | PTail]) ->
    is_match(S, PTail) orelse (length(S) > 0 andalso is_match(tl(S), [H | PTail])).
is_match(_, _) -> false.
