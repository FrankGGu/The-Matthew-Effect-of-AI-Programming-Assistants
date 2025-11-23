-spec reverse_string(S :: list()) -> list().
reverse_string(S) ->
    reverse_string(S, 0, length(S) - 1).

reverse_string(S, Left, Right) when Left < Right ->
    NewS = swap(S, Left, Right),
    reverse_string(NewS, Left + 1, Right - 1);
reverse_string(S, _, _) -> S.

swap(S, Left, Right) ->
    lists:replace_at(S, Left, lists:nth(Right + 1, S)),
    lists:replace_at(S, Right, lists:nth(Left + 1, S)).
