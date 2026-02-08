-module(triangular_sum).
-export([triangular_sum/1]).

triangular_sum(Nums) ->
  lists:foldl(fun(N, Acc) -> reduce(Acc) end, Nums, lists:seq(1, length(Nums) - 1)).

reduce(Nums) ->
  lists:zipwith(fun(A, B) -> (A + B) rem 10 end, Nums, tl(Nums)).