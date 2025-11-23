-module(solution).
-export([maximum_xor_after_operations/1]).

maximum_xor_after_operations(Nums) ->
    Max = lists:max(Nums),
    MaxBor = lists:foldl(fun(N, Acc) -> Acc bor N end, 0, Nums),
    MaxBor bxor Max.