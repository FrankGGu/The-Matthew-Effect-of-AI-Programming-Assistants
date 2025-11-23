-module(palindrome_number).
-export([is_palindrome/1]).

is_palindrome(X) ->
  if
    X < 0 ->
      false;
    true ->
      IntegerList = integer_to_list(X),
      ReverseList = lists:reverse(IntegerList),
      IntegerList == ReverseList
  end.