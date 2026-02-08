-module(remove_element).
-export([remove_element/3]).

remove_element(Nums, Val, NewNums) ->
  remove_element(Nums, Val, [], NewNums).

remove_element([], _Val, Acc, lists:reverse(Acc)) ->
  [];
remove_element([H|T], Val, Acc, NewNums) ->
  if
    H =:= Val ->
      remove_element(T, Val, Acc, NewNums);
    true ->
      remove_element(T, Val, [H|Acc], NewNums)
  end.