-spec shortest_palindrome(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
shortest_palindrome(S) ->
    Len = length(S),
    case is_palindrome(S) of
        true -> S;
        false -> add_prefix(S, Len, 0)
    end.

is_palindrome(S) ->
    lists:reverse(S) == S.

add_prefix(S, Len, Start) when Start < Len ->
    Substring = lists:sublist(S, Start, Len - Start),
    NewString = lists:reverse(Substring) ++ S,
    add_prefix(S, Len, Start + 1);
add_prefix(S, _, _) -> S.
