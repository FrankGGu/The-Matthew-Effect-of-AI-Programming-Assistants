-module(solution).
-export([check_palindrome/1, can_split/2]).

check_palindrome(Str) ->
    StrLength = string:len(Str),
    HalfLength = StrLength div 2,
    FirstHalf = string:substr(Str, 1, HalfLength),
    SecondHalf = string:substr(Str, HalfLength + 1, StrLength - HalfLength),
    if
        StrLength rem 2 == 0 ->
            FirstHalf == string:reverse(SecondHalf);
        true ->
            FirstHalf == string:reverse(string:substr(SecondHalf, 1, HalfLength))
    end.

can_split(A, B) ->
    check_palindrome(A ++ B) orelse check_palindrome(B ++ A).