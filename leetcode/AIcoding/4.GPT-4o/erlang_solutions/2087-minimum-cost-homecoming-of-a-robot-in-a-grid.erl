-module(solution).
-export([min_cost_homecoming/2]).

min_cost_homecoming(Grid, Start) ->
    {X, Y} = Start,
    Size = length(Grid),
    MinCost = lists:duplicate(Size, lists:duplicate(Size, 0)),
    MinCost1 = calculate_cost(Grid, X, Y, Size, MinCost),
    MinCost1.

calculate_cost(Grid, X, Y, Size, MinCost) ->
    if
        X == 0, Y == 0 -> 
            lists:nth(1, lists:nth(1, Grid));
        X == 0 -> 
            calculate_cost(Grid, X, Y - 1, Size, MinCost) + lists:nth(1, lists:nth(Y + 1, Grid));
        Y == 0 -> 
            calculate_cost(Grid, X - 1, Y, Size, MinCost) + lists:nth(X + 1, lists:nth(1, Grid));
        true -> 
            MinCostX = calculate_cost(Grid, X - 1, Y, Size, MinCost),
            MinCostY = calculate_cost(Grid, X, Y - 1, Size, MinCost),
            MinCostZ = MinCostX + MinCostY + lists:nth(X + 1, lists:nth(Y + 1, Grid)),
            MinCostZ
    end.