-module(domino_tromino_tiling).
-export([num_tilings/1]).

num_tilings(n) ->
    num_tilings_helper(n, 1000000007).

num_tilings_helper(N, Mod) ->
    {F0, F1, L0, L1} = lists:foldl(
        fun(I, {F0Acc, F1Acc, L0Acc, L1Acc}) ->
            NewF0 = (F1Acc + L0Acc + L1Acc) rem Mod,
            NewL0 = (F0Acc + L1Acc) rem Mod,
            NewL1 = (F0Acc + L0Acc) rem Mod,
            {NewF0, F0Acc, NewL0, NewL1}
        end,
        {1, 1, 0, 0},
        lists:seq(2, N)
    ),
    F0.