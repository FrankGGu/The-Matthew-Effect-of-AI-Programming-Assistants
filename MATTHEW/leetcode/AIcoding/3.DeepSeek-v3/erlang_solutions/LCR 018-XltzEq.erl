-spec is_palindrome(S :: unicode:unicode_binary()) -> boolean().
is_palindrome(S) ->
    Cleaned = re:replace(S, "[^a-zA-Z0-9]", "", [global, {return, list}, caseless]),
    Lower = string:to_lower(Cleaned),
    Lower == lists:reverse(Lower).