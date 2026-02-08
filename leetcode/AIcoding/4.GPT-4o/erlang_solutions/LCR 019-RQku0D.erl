-module(solution).
-export([valid_palindrome/1]).

valid_palindrome(Str) ->
    valid_palindrome(Str, 0, string:len(Str) - 1, false).

valid_palindrome(Str, L, R, Deleted) when L >= R ->
    true;
valid_palindrome(Str, L, R, Deleted) ->
    case string:substr(Str, L + 1, 1) == string:substr(Str, R + 1, 1) of
        true -> valid_palindrome(Str, L + 1, R - 1, Deleted);
        false when Deleted =:= false ->
            valid_palindrome(Str, L + 1, R, true) orelse valid_palindrome(Str, L, R - 1, true);
        false -> false
    end.