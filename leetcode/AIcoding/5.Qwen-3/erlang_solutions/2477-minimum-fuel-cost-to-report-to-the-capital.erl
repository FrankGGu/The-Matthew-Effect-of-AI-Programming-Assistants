-module(minimum_fuel_cost).
-export([minimumFuelCost/2]).

minimumFuelCost(N, roads) ->
    Graph = build_graph(roads),
    {_, Total} = dfs(0, -1, Graph, 0),
    Total.

build_graph(roads) ->
    lists:foldl(fun({A,B}, Acc) ->
        Acc1 = maps:update_with(A, fun(Val) -> [B | Val] end, [], Acc),
        maps:update_with(B, fun(Val) -> [A | Val] end, [], Acc1)
    end, #{}, roads).

dfs(Node, Parent, Graph, Fuel) ->
    Children = maps:get(Node, Graph, []),
    TotalFuel = Fuel,
    lists:foldl(fun(Child, {FuelAcc, TotalAcc}) ->
        if Child /= Parent ->
            {ChildFuel, ChildTotal} = dfs(Child, Node, Graph, Fuel + 1),
            {FuelAcc + ChildFuel, TotalAcc + ChildTotal};
        true ->
            {FuelAcc, TotalAcc}
        end
    end, {0, 0}, Children).