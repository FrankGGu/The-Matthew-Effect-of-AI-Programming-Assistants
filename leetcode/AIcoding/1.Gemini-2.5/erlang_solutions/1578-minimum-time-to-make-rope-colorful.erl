-module(solution).
-export([min_cost/2]).

min_cost(Colors, NeededTime) ->
    Tuples = lists:zip(Colors, NeededTime),
    case Tuples of
        [] -> 0;
        [{C1, T1} | Rest] ->
            min_cost_loop(Rest, C1, T1, T1, 0)
    end.

min_cost_loop([], _CurrentBlockColor, CurrentBlockMaxTime, CurrentBlockSumTime, TotalCost) ->
    TotalCost + (CurrentBlockSumTime - CurrentBlockMaxTime);
min_cost_loop([{NextC, NextT} | Rest], CurrentBlockColor, CurrentBlockMaxTime, CurrentBlockSumTime, TotalCost) ->
    if NextC == CurrentBlockColor ->
        NewMaxTime = max(CurrentBlockMaxTime, NextT),
        NewSumTime = CurrentBlockSumTime + NextT,
        min_cost_loop(Rest, CurrentBlockColor, NewMaxTime, NewSumTime, TotalCost);
    true ->
        CostForCurrentBlock = CurrentBlockSumTime - CurrentBlockMaxTime,
        NewTotalCost = TotalCost + CostForCurrentBlock,
        min_cost_loop(Rest, NextC, NextT, NextT, NewTotalCost)
    end.