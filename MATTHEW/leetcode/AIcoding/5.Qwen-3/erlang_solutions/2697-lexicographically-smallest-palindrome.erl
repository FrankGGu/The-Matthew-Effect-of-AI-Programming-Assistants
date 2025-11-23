-module(lexicographically_smallest_palindrome).
-export([make_palindrome/1]).

make_palindrome(S) ->
    make_palindrome(S, 0, length(S) - 1, lists:reverse(S)).

make_palindrome(_, L, R, _) when L >= R ->
    S;

make_palindrome(S, L, R, Rev) ->
    case lists:nth(L + 1, S) of
        lists:nth(R + 1, Rev) ->
            make_palindrome(S, L + 1, R - 1, Rev);
        C ->
            [C | lists:sublist(S, L + 1, R - L)] ++ [C]
    end.