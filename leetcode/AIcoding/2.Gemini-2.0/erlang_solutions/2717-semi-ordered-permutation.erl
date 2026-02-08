-module(solution).
-export([semi_ordered_permutation/1]).

semi_ordered_permutation(Nums) ->
  semi_ordered_permutation(Nums, 1, length(Nums)).

semi_ordered_permutation(Nums, Min, Max) ->
  {MinIndex, _} = lists:min([ {I, X} || {I, X} <- lists:zip(lists:seq(1, length(Nums)), Nums), X == Min ]),
  {MaxIndex, _} = lists:max([ {I, X} || {I, X} <- lists:zip(lists:seq(1, length(Nums)), Nums), X == Max ]),

  if MinIndex < MaxIndex then
    MinIndex - 1 + length(Nums) - MaxIndex
  else
    MinIndex - 1 + length(Nums) - MaxIndex -1
  end.