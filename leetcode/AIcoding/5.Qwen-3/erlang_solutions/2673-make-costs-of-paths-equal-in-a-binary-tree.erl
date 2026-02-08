-module(solution).
-export([minCost/1]).

minCost(Root) ->
    min_cost(Root, 0).

min_cost(nil, _) ->
    0;
min_cost({Value, Left, Right}, Cost) ->
    LeftCost = min_cost(Left, Cost + Value),
    RightCost = min_cost(Right, Cost + Value),
    min(LeftCost, RightCost).