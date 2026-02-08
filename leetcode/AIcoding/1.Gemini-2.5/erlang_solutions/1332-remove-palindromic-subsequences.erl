-module(solution).
-export([remove_palindromic_subsequences/1]).

is_palindrome(S) ->
    S == lists:reverse(S).

remove_palindromic_subsequences(S) ->
    case is_palindrome(S) of
        true -> 1;
        false -> 2
    end.