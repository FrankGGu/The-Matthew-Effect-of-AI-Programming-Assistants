-module(solution).
-export([findMissingAndRepeatedValues/1]).

findMissingAndRepeatedValues(Nums) ->
    N = length(Nums),

    ExpectedSum = N * (N + 1) div 2,
    ExpectedSumSq = N * (N + 1) * (2 * N + 1) div 6,

    {ActualSum, ActualSumSq} = lists:foldl(
        fun(X, {AccSum, AccSumSq}) ->
            {AccSum + X, AccSumSq + X*X}
        end,
        {0, 0},
        Nums
    ),

    DiffSum = ActualSum - ExpectedSum,
    DiffSumSq = ActualSumSq - ExpectedSumSq,

    SumAB = DiffSumSq div DiffSum,

    A = (DiffSum + SumAB) div 2,
    B = (SumAB - DiffSum) div 2,

    [A, B].