-module(solution).
-export([min_fuel_cost/3]).

min_fuel_cost(N, Roads, Seats) ->
    Adj = build_adj(N, Roads),
    {_TotalPeople, FinalFuel} = dfs(0, -1, Adj, Seats, 0),
    FinalFuel.

build_adj(_N, Roads) ->
    lists:foldl(
        fun([U, V], Acc) ->
            Acc1 = maps:update_with(U, fun(L) -> [V | L] end, [V], Acc),
            maps:update_with(V, fun(L) -> [U | L] end, [U], Acc1)
        end,
        maps:new(),
        Roads
    ).

dfs(Node, Parent, Adj, Seats, CurrentTotalFuel) ->
    Neighbors = maps:get(Node, Adj, []),

    lists:foldl(
        fun(Neighbor, {AccPeople, AccFuel}) ->
            if Neighbor == Parent ->
                {AccPeople, AccFuel};
            true ->
                {SubPeople, FuelAfterSubtree} = dfs(Neighbor, Node, Adj, Seats, AccFuel),

                CarsNeeded = (SubPeople + Seats - 1) div Seats,

                {AccPeople + SubPeople, FuelAfterSubtree + CarsNeeded}
            end
        end,
        {1, CurrentTotalFuel}, % Initial: 1 person for current node, CurrentTotalFuel is passed down
        Neighbors
    ).