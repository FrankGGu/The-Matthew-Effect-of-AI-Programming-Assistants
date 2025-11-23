-module(solution).
-export([valid_palindrome/1]).

valid_palindrome(Str) ->
    valid_palindrome(Str, 0, string:length(Str) - 1, false).

valid_palindrome(Str, L, R, True) when L >= R ->
    true;
valid_palindrome(Str, L, R, false) ->
    case string:substr(Str, L + 1, 1) == string:substr(Str, R, 1) of
        true -> valid_palindrome(Str, L + 1, R - 1, false);
        false ->
            case string:substr(Str, L, 1) == string:substr(Str, R - 1, 1) of
                true -> valid_palindrome(Str, L, R - 1, true);
                false -> false
            end
    end.