-module(valid_palindrome_ii).
-export([is_valid_palindrome/1]).

is_valid_palindrome(S) ->
    is_valid_palindrome(S, 0, length(S) - 1).

is_valid_palindrome(_, Left, Right) when Left >= Right ->
    true;
is_valid_palindrome(S, Left, Right) ->
    case (string:at(S, Left) == string:at(S, Right)) of
        true ->
            is_valid_palindrome(S, Left + 1, Right - 1);
        false ->
            is_valid_palindrome(S, Left + 1, Right) orelse is_valid_palindrome(S, Left, Right - 1)
    end.