-module(reverse_list).
-export([reverse_list/1]).

-spec reverse_list(list()) -> list().
reverse_list(List) ->
  reverse_list(List, []).

reverse_list([], Acc) ->
  Acc;
reverse_list([H|T], Acc) ->
  reverse_list(T, [H|Acc]).