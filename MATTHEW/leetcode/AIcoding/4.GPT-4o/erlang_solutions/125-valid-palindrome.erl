-spec is_palindrome(S :: unicode:unicode_binary()) -> boolean().
is_palindrome(S) ->
    Cleaned = lists:filter(fun(C) -> C >= $0 and C =< $9 or (C >= $a and C =< $z) or (C >= $A and C =< $Z) end, string:lowercase(S)),
    is_palindrome(Cleaned, length(Cleaned) - 1, 0).

is_palindrome(_, -1, _) -> true;
is_palindrome(Cleaned, Index, Start) when Start < Index ->
    case lists:nth(Start + 1, Cleaned) == lists:nth(Index + 1, Cleaned) of
        true -> is_palindrome(Cleaned, Index - 1, Start + 1);
        false -> false
    end.
