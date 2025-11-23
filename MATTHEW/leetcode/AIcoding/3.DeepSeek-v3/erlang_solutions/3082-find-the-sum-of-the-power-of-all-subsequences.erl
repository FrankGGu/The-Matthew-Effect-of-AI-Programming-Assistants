-module(solution).
-export([sum_of_power/1]).

sum_of_power(Nums) ->
    Mod = 1000000007,
    N = length(Nums),
    DP = lists:foldl(fun(_, Acc) -> [0 | Acc] end, [1], lists:seq(1, N)),
    {Sum, Min} = lists:foldl(
        fun(Num, {SumAcc, MinAcc}) ->
            NewMinAcc = min(MinAcc, Num),
            Power = Num * Num * NewMinAcc,
            NewSumAcc = (SumAcc + Power) rem Mod,
            {NewSumAcc, NewMinAcc}
        end,
        {0, 0},
        Nums
    ),
    Sum.