-module(solution).
-export([maximum_score/2]).

maximum_score(Nums, Multipliers) ->
    M = length(Multipliers),
    N = length(Nums),
    DP = array:new([{size, M + 1}, {default, 0}]),
    maximum_score(Nums, Multipliers, N, M, DP).

maximum_score(Nums, Multipliers, N, M, DP) ->
    lists:foldl(fun(MIdx, DPAcc) ->
        Left = M - MIdx,
        Right = N - 1 - (MIdx - Left),
        LeftVal = case Left > 0 of
            true -> array:get(Left - 1, DPAcc) + lists:nth(Left, Nums) * lists:nth(MIdx + 1, Multipliers);
            false -> -1000000000
        end,
        RightVal = case Right < N - 1 of
            true -> array:get(Left, DPAcc) + lists:nth(Right + 1, Nums) * lists:nth(MIdx + 1, Multipliers);
            false -> -1000000000
        end,
        array:set(Left, max(LeftVal, RightVal), DPAcc)
    end, DP, lists:seq(0, M - 1)),
    lists:foldl(fun(I, MaxScore) -> max(MaxScore, array:get(I, DP)) end, -1000000000, lists:seq(0, M)).