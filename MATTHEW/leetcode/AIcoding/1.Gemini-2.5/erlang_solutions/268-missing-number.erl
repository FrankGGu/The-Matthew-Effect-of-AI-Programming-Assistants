-module(solution).
-export([missingNumber/1]).

missingNumber(Nums) ->
    N = length(Nums),
    ExpectedSum = N * (N + 1) div 2,
    ActualSum = lists:foldl(fun(X, Acc) -> X + Acc end, 0, Nums),
    ExpectedSum - ActualSum.