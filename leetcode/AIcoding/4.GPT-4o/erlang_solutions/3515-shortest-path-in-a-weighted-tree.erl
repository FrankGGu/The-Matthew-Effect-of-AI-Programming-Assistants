-module(solution).
-export([shortestPath/3]).

shortestPath(N, Edges, Queries) ->
    Graph = build_graph(N, Edges),
    lists:map(fun({X, Y}) -> dijkstra(Graph, X, Y) end, Queries).

build_graph(N, Edges) ->
    Graph = lists:foldl(fun({U, V, W}, Acc) ->
        maps:update_with(U, fun(L) -> [{V, W} | L] end, fun() -> [{V, W}] end, Acc)
        |> maps:update_with(V, fun(L) -> [{U, W} | L] end, fun() -> [{U, W}] end)
    end, maps:new(), Edges),
    Graph.

dijkstra(Graph, Start, End) ->
    D = maps:from_list([{Start, 0}]),
    PQ = [{0, Start}],
    dijkstra_loop(PQ, D, Graph, End).

dijkstra_loop([], D, _, _) ->
    case maps:is_key(End, D) of
        true -> maps:get(End, D);
        false -> -1
    end;
dijkstra_loop([{Cost, Node} | Rest], D, Graph, End) ->
    case Node == End of
        true -> Cost;
        false ->
            Neighbors = maps:get(Node, Graph, []),
            {D1, PQ1} = lists:foldl(fun({Neighbor, Weight}, {DAcc, PQAcc}) ->
                NewCost = Cost + Weight,
                case maps:get(Neighbor, DAcc, infinity) > NewCost of
                    true -> {maps:put(Neighbor, NewCost, DAcc), [{NewCost, Neighbor} | PQAcc]};
                    false -> {DAcc, PQAcc}
                end
            end, {D, Rest}, Neighbors),
            dijkstra_loop(PQ1, D1, Graph, End)
    end.