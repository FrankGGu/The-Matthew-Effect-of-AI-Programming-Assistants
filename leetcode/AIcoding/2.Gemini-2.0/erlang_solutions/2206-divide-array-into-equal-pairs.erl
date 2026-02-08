-module(divide_array).
-export([divide_array/1]).

divide_array(Nums) ->
  divide_array(Nums, []).

divide_array([], _) ->
  true;
divide_array([H|T], Seen) ->
  case lists:member(H, Seen) of
    true ->
      divide_array(T, lists:delete(H,Seen));
    false ->
      divide_array(T, [H|Seen])
  end.