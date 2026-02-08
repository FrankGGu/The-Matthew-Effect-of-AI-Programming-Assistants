-module(solution).
-export([solve/1]).

solve(Nums) ->
  XorSum = lists:foldl(fun(Acc, N) -> Acc bxor N end, 0, Nums),
  XorSum * length(Nums).