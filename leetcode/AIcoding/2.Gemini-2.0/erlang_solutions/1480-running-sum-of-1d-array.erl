-module(running_sum).
-export([running_sum/1]).

running_sum(Nums) ->
  running_sum(Nums, 0, []).

running_sum([], _, Acc) ->
  lists:reverse(Acc);
running_sum([H|T], Sum, Acc) ->
  NewSum = Sum + H,
  running_sum(T, NewSum, [NewSum|Acc]).