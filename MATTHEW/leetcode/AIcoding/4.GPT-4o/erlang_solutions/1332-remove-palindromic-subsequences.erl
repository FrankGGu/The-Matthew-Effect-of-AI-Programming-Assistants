-module(solution).
-export([remove_palindromic_subsequences/1]).

remove_palindromic_subsequences(Str) ->
    case is_palindrome(Str) of
        true -> 1;
        false -> 2
    end.

is_palindrome(Str) ->
    Str == lists:reverse(Str).