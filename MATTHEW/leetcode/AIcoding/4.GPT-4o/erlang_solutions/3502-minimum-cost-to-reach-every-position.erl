-module(solution).
-export([minCost/2]).

minCost(positions, start) ->
    N = length(positions),
    MinCost = lists:duplicate(N, infinity),
    MinCost1 = lists:replace(MinCost, start, 0),
    min_cost_helper(positions, MinCost1, start).

min_cost_helper(Positions, MinCost, Start) ->
    Queue = [{0, Start}],
    min_cost_loop(Positions, MinCost, Queue).

min_cost_loop(_, MinCost, []) ->
    MinCost;
min_cost_loop(Positions, MinCost, [{Cost, Pos} | Rest]) ->
    NewMinCost = lists:replace(MinCost, Pos, Cost),
    NewCost = Cost + 1,
    NewPositions = lists:filter(fun(P) -> NewCost < lists:nth(P + 1, NewMinCost) end, positions_indices(Positions)),
    NewQueue = lists:foldl(fun(P, Acc) -> [{NewCost, P} | Acc] end, Rest, NewPositions),
    min_cost_loop(Positions, NewMinCost, NewQueue).

positions_indices(Positions) ->
    lists:seq(0, length(Positions) - 1).