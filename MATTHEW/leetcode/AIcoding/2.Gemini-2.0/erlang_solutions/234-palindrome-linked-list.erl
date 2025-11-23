-module(palindrome_linked_list).
-export([is_palindrome/1]).

-spec is_palindrome(list()) -> boolean().
is_palindrome(List) ->
  Reverse = lists:reverse(List),
  List =:= Reverse.