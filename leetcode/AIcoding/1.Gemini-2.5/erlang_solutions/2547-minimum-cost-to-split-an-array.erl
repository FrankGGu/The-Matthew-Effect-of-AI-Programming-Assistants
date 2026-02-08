-module(solution).
-export([min_cost_to_split/2]).

min_cost_to_split(Nums, Price) ->
    N = length(Nums),
    MaxNumVal = 100000,
    CountsArraySize = MaxNumVal + 1,

    Dp = array:new({size, N + 1}, {default, infinity()}),
    Dp0 = array:set(0, 0, Dp),

    FinalDp = lists:foldl(fun(I, CurrentDp) ->
        Counts = array:new({size, CountsArraySize}, {default, 0}),
        CurrentTrimCost = 0,

        {MinCostForI, _FinalCounts, _FinalTrimCost} = lists:foldl(fun(J, {AccMinCost, AccCounts, AccTrimCost}) ->
            Num = lists:nth(J + 1, Nums),

            NumCount = array:get(Num, AccCounts),
            NewCounts = array:set(Num, NumCount + 1, AccCounts),

            NewTrimCost = 
                if NumCount == 1 -> AccTrimCost + 1;
                   true -> AccTrimCost
                end,

            Cost = array:get(J, CurrentDp) + Price + NewTrimCost,

            {min(AccMinCost, Cost), NewCounts, NewTrimCost}
        end, {infinity(), Counts, CurrentTrimCost}, lists:seq(I - 1, 0, -1)),

        array:set(I, MinCostForI, CurrentDp)
    end, Dp0, lists:seq(1, N)),

    array:get(N, FinalDp).

infinity() -> 1 bsl 60.