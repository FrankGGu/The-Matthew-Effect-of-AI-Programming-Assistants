-module(break_palindrome).
-export([break_palindrome/1]).

break_palindrome(Palindrome) ->
  Len = length(Palindrome),
  if
    Len =< 1 ->
      "";
    true ->
      case find_non_a(Palindrome) of
        {true, Index} ->
          string:set_element(Index, Palindrome, $a);
        false ->
          string:set_element(Len - 1, Palindrome, $b)
      end
  end.

find_non_a(Palindrome) ->
  Len = length(Palindrome),
  find_non_a_helper(Palindrome, 0, Len).

find_non_a_helper(_Palindrome, Index, Len) when Index >= Len div 2 ->
  {false, -1};
find_non_a_helper(Palindrome, Index, Len) ->
  if
    list_to_integer(string:substr(Palindrome, Index + 1, 1)) /= $a ->
      {true, Index};
    true ->
      find_non_a_helper(Palindrome, Index + 1, Len)
  end.