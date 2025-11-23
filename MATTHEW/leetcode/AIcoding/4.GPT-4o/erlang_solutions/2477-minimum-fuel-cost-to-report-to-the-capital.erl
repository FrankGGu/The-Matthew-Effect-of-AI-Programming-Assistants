-module(minimum_fuel_cost).
-export([minimum_fuel_cost/2]).

minimum_fuel_cost(Roads, Seats) ->
    Graph = build_graph(Roads),
    {TotalFuel, _} = dfs(1, Graph, Seats, 0, #{1 => 1}),
    TotalFuel.

build_graph(Roads) ->
    lists:foldl(fun({A, B}, Acc) ->
        MapA = maps:update_with(A, fun(X) -> [B | X] end, [B], Acc),
        MapB = maps:update_with(B, fun(X) -> [A | X] end, [A], MapA)
    end, #{}, Roads).

dfs(Node, Graph, Seats, AccumulatedFuel, Visited) ->
    Neighbors = maps:get(Node, Graph, []),
    {Fuel, Count} = lists:foldl(fun(Neighbor, {F, C}) ->
        case maps:is_key(Neighbor, Visited) of
            true -> {F, C};
            false ->
                {SubFuel, SubCount} = dfs(Neighbor, Graph, Seats, 0, maps:put(Neighbor, 1, Visited)),
                {F + SubFuel + (SubCount div Seats) + (if SubCount rem Seats > 0 -> 1; true -> 0 end), C + SubCount + 1}
        end
    end, {AccumulatedFuel, 0}, Neighbors),
    {Fuel, Count}.