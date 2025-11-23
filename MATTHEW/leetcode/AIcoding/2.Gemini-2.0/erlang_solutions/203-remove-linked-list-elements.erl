-module(remove_linked_list_elements).
-export([remove_elements/2]).

remove_elements(Head, Val) ->
  remove_elements(Head, Val, null).

remove_elements(null, _, Acc) ->
  lists:reverse(Acc);
remove_elements({Val, Rest}, Val, Acc) ->
  remove_elements(Rest, Val, Acc);
remove_elements({H, Rest}, Val, Acc) ->
  remove_elements(Rest, Val, [H | Acc]).