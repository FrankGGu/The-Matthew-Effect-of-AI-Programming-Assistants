-module(valid_palindrome_ii).
-export([is_validPalindrome/1]).

is_validPalindrome(S) ->
    is_valid_palindrome(S, 0, erlang:length(S) - 1).

is_valid_palindrome(S, Left, Right) when Left >= Right ->
    true;
is_validPalindrome(S, Left, Right) ->
    case erlang:element(Left + 1, S) == erlang:element(Right + 1, S) of
        true ->
            is_valid_palindrome(S, Left + 1, Right - 1);
        false ->
            is_valid_palindrome(S, Left + 1, Right) orelse is_valid_palindrome(S, Left, Right - 1)
    end.