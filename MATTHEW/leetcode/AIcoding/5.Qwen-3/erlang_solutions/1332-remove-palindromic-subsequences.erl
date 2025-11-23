-module(remove_palindromic_subsequences).
-export([remove_palindromic_subsequences/1]).

remove_palindromic_subsequences(S) ->
    case S of
        [] -> 0;
        _ ->
            case is_palindrome(S) of
                true -> 1;
                false -> 2
            end
    end.

is_palindrome([]) -> true;
is_palindrome([H|T]) ->
    lists:reverse([H|T]) == [H|T].