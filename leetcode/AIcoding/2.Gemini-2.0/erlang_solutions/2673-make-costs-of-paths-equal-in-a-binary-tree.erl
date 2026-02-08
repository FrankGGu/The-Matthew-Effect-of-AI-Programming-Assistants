-module(make_costs_equal).
-export([min_increments/1]).

min_increments(Costs) ->
    {_, Increments} = min_increments_helper(Costs, length(Costs)),
    Increments.

min_increments_helper(Costs, N) ->
    min_increments_helper(Costs, N, N div 2).

min_increments_helper(Costs, N, 0) ->
    {Costs, 0};
min_increments_helper(Costs, N, I) ->
    {LeftCosts, LeftIncrements} = min_increments_helper(Costs, N, I * 2);
    {RightCosts, RightIncrements} = min_increments_helper(Costs, N, I * 2 + 1);
    Left = LeftCosts !! (I * 2 -1);
    Right = RightCosts !! (I * 2);
    Increments = LeftIncrements + RightIncrements + abs(Left - Right);
    NewCost = Costs !! (I - 1) + max(Left, Right);
    NewCosts = lists:sublist(Costs, 1, I-1) ++ [NewCost] ++ lists:sublist(Costs, I+1, N - I);
    {NewCosts, Increments}.
min_increments_helper(Costs, N, I) when I * 2 > N ->
    {Costs, 0}.