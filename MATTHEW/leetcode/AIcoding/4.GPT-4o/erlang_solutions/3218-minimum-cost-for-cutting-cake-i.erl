-module(solution).
-export([min_cost/2]).

min_cost(Cuts, n) ->
    Cuts1 = lists:sort(Cuts),
    min_cost(Cuts1, n, 0).

min_cost([], _N, Cost) -> 
    Cost;
min_cost(Cuts, N, Cost) ->
    TotalLength = length(Cuts) + 1,
    {MinCost, Cuts1} = min_cost_helper(Cuts, N, TotalLength, Cost),
    MinCost.

min_cost_helper([], _N, _TotalLength, Cost) -> 
    {Cost, []};
min_cost_helper([H | T], N, TotalLength, Cost) ->
    NewCost = Cost + H * (N - TotalLength + 1),
    min_cost_helper(T, N, TotalLength - 1, NewCost).