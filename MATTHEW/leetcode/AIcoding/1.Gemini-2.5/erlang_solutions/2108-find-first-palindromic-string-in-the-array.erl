-module(solution).
-export([first_palindrome/1]).

first_palindrome(Words) ->
    find_first_palindrome(Words).

find_first_palindrome([]) ->
    "";
find_first_palindrome([H|T]) ->
    if is_palindrome(H) ->
            H;
       true ->
            find_first_palindrome(T)
    end.

is_palindrome(S) ->
    S == lists:reverse(S).