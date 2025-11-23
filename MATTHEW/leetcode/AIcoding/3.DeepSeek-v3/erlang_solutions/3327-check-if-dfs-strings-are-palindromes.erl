-spec is_palindrome(S :: unicode:unicode_binary()) -> boolean().
is_palindrome(S) ->
    S == lists:reverse(S).

-spec dfs_palindromes(S :: unicode:unicode_binary()) -> boolean().
dfs_palindromes(S) ->
    case is_palindrome(S) of
        true -> true;
        false ->
            case length(S) rem 2 == 0 of
                true ->
                    Half = length(S) div 2,
                    S1 = string:slice(S, 0, Half),
                    S2 = string:slice(S, Half, Half),
                    dfs_palindromes(S1) andalso dfs_palindromes(S2);
                false -> false
            end
    end.