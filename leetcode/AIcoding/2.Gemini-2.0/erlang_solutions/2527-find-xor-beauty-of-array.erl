-module(xor_beauty).
-export([xor_beauty/1]).

xor_beauty(Nums) ->
  lists:foldl(fun(X, Acc) -> X band Acc end, 0, Nums).