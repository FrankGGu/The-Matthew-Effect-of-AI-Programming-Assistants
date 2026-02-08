-module(valid_palindrome_ii).
-export([valid_palindrome/1]).

valid_palindrome(S) ->
  valid_palindrome_helper(S, 0, length(S) - 1, true).

valid_palindrome_helper(S, L, R, AllowedDeletion) ->
  case L >= R of
    true ->
      true;
    false ->
      case element(1, string:substr(S, L+1, 1)) =:= element(1, string:substr(S, R+1, 1)) of
        true ->
          valid_palindrome_helper(S, L + 1, R - 1, AllowedDeletion);
        false ->
          case AllowedDeletion of
            true ->
              valid_palindrome_helper(S, L + 1, R, false) orelse valid_palindrome_helper(S, L, R - 1, false);
            false ->
              false
          end
      end
  end.