-module(solution).
-export([stoneGameVIII/1]).

stoneGameVIII(Stones) ->
    N = length(Stones),
    P = lists:scanl(fun(X, Sum) -> Sum + X end, 0, Stones),

    {_MinValAccFinal, DpN} = lists:foldl(
        fun(Current_P_i, {MinValAcc, _LastDpI}) ->
            Dp_i = Current_P_i - MinValAcc,
            NewMinValAcc = min(MinValAcc, Current_P_i + Dp_i),
            {NewMinValAcc, Dp_i}
        end,
        {0, 0},
        tl(P)
    ),
    DpN.