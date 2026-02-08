-module(reverse_string).
-export([reverseString/1]).

reverseString(S) ->
  reverseStringHelper(S, []).

reverseStringHelper([], Acc) ->
  list_to_binary(lists:reverse(Acc));
reverseStringHelper([H|T], Acc) ->
  reverseStringHelper(T, [H|Acc]).