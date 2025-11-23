-module(longest_palindrome).
-export([longest_palindrome/1]).

longest_palindrome(Words) ->
  longest_palindrome_helper(Words, 0, #{}, 0).

longest_palindrome_helper([], Length, _Map, HasMiddle) ->
  Length + (HasMiddle * 2);
longest_palindrome_helper([Word | Rest], Length, Map, HasMiddle) ->
  Reversed = lists:reverse(Word),
  case maps:get(Reversed, Map, 0) of
    0 ->
      NewMap = maps:update_with(Word, fun(X) -> X + 1 end, 1, Map),
      longest_palindrome_helper(Rest, Length, NewMap, HasMiddle);
    N ->
      NewMap = maps:update_with(Reversed, fun(X) -> X - 1 end, 0, Map),
      NewHasMiddle = case Word == Reversed of
        true -> HasMiddle;
        false -> HasMiddle
      end,
      longest_palindrome_helper(Rest, Length + 4, NewMap, NewHasMiddle)
  end.