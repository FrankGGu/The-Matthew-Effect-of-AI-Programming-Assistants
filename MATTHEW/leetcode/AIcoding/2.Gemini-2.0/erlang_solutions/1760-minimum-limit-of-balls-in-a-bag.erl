-module(minimum_limit_balls).
-export([minimum_size/2]).

minimum_size(Nums, MaxOperations) ->
  minimum_size(Nums, MaxOperations, 1, lists:max(Nums)).

minimum_size(Nums, MaxOperations, Low, High) when Low > High ->
  Low;
minimum_size(Nums, MaxOperations, Low, High) ->
  Mid = (Low + High) div 2,
  Ops = sum_operations(Nums, Mid),
  if Ops > MaxOperations ->
    minimum_size(Nums, MaxOperations, Mid + 1, High);
  true ->
    minimum_size(Nums, MaxOperations, Low, Mid - 1)
  end.

sum_operations(Nums, Mid) ->
  lists:sum([max(0, (N - 1) div Mid) || N <- Nums]).