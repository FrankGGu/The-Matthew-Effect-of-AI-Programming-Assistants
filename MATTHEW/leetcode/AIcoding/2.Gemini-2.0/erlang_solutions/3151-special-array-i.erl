-module(special_array_i).
-export([special_array/1]).

special_array(Nums) ->
  special_array_helper(Nums, 0).

special_array_helper(Nums, X) ->
  Count = length([N || N <- Nums, N >= X]);
  if Count == X then
    X
  else if Count < X then
    -1
  else
    special_array_helper(Nums, X + 1)
  end.