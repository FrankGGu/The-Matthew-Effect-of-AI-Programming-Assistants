-module(solution).
-export([find_first_palindromic_string/1]).

find_first_palindromic_string(Words) ->
    find_first_palindromic(Words).

find_first_palindromic([]) ->
    "";
find_first_palindromic([H | T]) ->
    case is_palindrome(H) of
        true -> H;
        false -> find_first_palindromic(T)
    end.

is_palindrome(Str) ->
    Str == lists:reverse(Str).