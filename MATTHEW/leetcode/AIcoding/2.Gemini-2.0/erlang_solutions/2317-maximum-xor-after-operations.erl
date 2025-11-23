-module(maximum_xor).
-export([maximum_xor/1]).

maximum_xor(Nums) ->
  lists:foldl(fun(X, Acc) -> Acc bor X end, 0, Nums).