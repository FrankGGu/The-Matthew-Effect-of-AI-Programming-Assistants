-module(solution).
-export([is_palindrome/1]).

is_palindrome(S) ->
    is_palindrome(S, []).

is_palindrome([], []) ->
    true;
is_palindrome([H|T], []) ->
    is_palindrome(T, [H]);
is_palindrome([H|T], [H|Tail]) ->
    is_palindrome(T, Tail);
is_palindrome([H|T], [X|Tail]) ->
    is_palindrome(T, [H|X|Tail]).