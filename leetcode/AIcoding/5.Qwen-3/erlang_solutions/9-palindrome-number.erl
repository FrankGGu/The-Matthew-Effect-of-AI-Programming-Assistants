-module(palindrome_number).
-export([is_palindrome/1]).

is_palindrome(N) when is_integer(N) ->
    if
        N < 0 -> false;
        true -> is_palindrome(N, 0)
    end.

is_palindrome(0, Rev) -> Rev == 0;
is_palindrome(N, Rev) ->
    is_palindrome(N div 10, Rev * 10 + N rem 10).