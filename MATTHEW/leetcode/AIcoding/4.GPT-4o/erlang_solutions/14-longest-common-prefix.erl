-spec longest_common_prefix(Strs :: [unicode:unicode_binary()]) -> unicode:unicode_binary().
longest_common_prefix([H | T]) ->
    longest_common_prefix(H, T, H);
longest_common_prefix([]) -> "".

longest_common_prefix(_, [], Prefix) -> Prefix;
longest_common_prefix(Prefix, [H | T], _) when Prefix == "" -> "";
longest_common_prefix(Prefix, [H | T], _) ->
    NewPrefix = common_prefix(Prefix, H),
    longest_common_prefix(NewPrefix, T, NewPrefix).

common_prefix(Prefix, Str) ->
    common_prefix(Prefix, Str, []).

common_prefix([], _, Acc) -> lists:reverse(Acc);
common_prefix([H | T], [H2 | T2], Acc) when H == H2 ->
    common_prefix(T, T2, [H | Acc]);
common_prefix(_, _, Acc) -> lists:reverse(Acc).
