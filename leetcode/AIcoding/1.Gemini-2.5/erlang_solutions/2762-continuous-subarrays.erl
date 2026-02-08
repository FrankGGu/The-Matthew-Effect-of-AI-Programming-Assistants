-module(solution).
-export([solve/1]).

solve(Nums) ->
    N = length(Nums),
    (N * (N + 1)) div 2.