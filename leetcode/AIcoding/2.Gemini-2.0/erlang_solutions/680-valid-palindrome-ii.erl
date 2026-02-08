-module(valid_palindrome_ii).
-export([valid_palindrome/1]).

valid_palindrome(S) ->
    valid_palindrome_helper(S, 0, length(S) - 1, false).

valid_palindrome_helper(S, L, R, Deleted) ->
    case L >= R of
        true ->
            true;
        false ->
            case element(1, string:slice(S, L, 1)) =:= element(1, string:slice(S, R, 1)) of
                true ->
                    valid_palindrome_helper(S, L + 1, R - 1, Deleted);
                false ->
                    case Deleted of
                        true ->
                            false;
                        false ->
                            valid_palindrome_helper(S, L + 1, R, true) orelse valid_palindrome_helper(S, L, R - 1, true)
                    end
            end
    end.