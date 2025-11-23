-module(solution).
-export([maximum_count/1]).

maximum_count(Nums) ->
  PosCount = lists:foldl(fun(X, Acc) -> if X > 0 -> Acc + 1; true -> Acc end end, 0, Nums),
  NegCount = lists:foldl(fun(X, Acc) -> if X < 0 -> Acc + 1; true -> Acc end end, 0, Nums),
  max(PosCount, NegCount).