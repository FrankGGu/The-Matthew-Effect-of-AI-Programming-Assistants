-module(distinct_subseq_ii).
-export([distinct_subseq_ii/1]).

distinct_subseq_ii(S) ->
    Mod = 1000000007,
    DP = array:new(26, {default, 0}),
    Total = 1,
    {_, Res} = lists:foldl(fun(Char, {DPAcc, TotalAcc}) ->
        Index = Char - $a + 1,
        Prev = array:get(Index - 1, DPAcc),
        NewTotal = (TotalAcc * 2 - Prev + Mod) rem Mod,
        NewDP = array:set(Index - 1, TotalAcc, DPAcc),
        {NewDP, NewTotal}
    end, {DP, Total}, S),
    Res - 1.