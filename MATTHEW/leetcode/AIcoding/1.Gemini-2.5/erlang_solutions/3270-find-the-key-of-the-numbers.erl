-module(solution).
-export([find_the_key/1]).

find_the_key(Nums) ->
    N = length(Nums),
    ExpectedSum = N * (N + 1) div 2,
    ActualSum = lists:sum(Nums),
    ExpectedSum - ActualSum.