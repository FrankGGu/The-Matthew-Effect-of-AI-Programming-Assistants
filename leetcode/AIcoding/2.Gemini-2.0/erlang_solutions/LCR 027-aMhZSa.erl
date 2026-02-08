-module(palindrome_linked_list).
-export([isPalindrome/1]).

-spec isPalindrome(list()) -> boolean().
isPalindrome(List) ->
  reverse(List) == List.

reverse(List) ->
  reverse(List, []).

reverse([], Acc) ->
  Acc;
reverse([H|T], Acc) ->
  reverse(T, [H|Acc]).