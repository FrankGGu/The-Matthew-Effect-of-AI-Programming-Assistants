-module(single_number).
-export([single_number/1]).

single_number(Nums) ->
  single_number(Nums, 0).

single_number([], Acc) ->
  Acc;
single_number([H|T], Acc) ->
  single_number(T, Acc bxor H).