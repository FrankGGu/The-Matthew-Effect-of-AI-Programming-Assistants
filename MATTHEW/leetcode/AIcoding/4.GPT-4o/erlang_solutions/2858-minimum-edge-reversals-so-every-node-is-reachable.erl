-module(solution).
-export([min_edge_reversals/2]).

min_edge_reversals(N, Edges) ->
    Graph = build_graph(N, Edges),
    {Reachable, _} = dfs(0, Graph, [], []),
    Missing = lists:subtract(lists:seq(0, N-1), Reachable),
    EdgeReversals = lists:map(fun(X) -> find_reverse_edges(X, Graph) end, Missing),
    lists:sum(EdgeReversals).

build_graph(N, Edges) ->
    lists:foldl(fun({A, B}, Acc) -> 
        maps:update_with(A, fun(Edges) -> [B | Edges] end, [B], Acc) 
    end, maps:new(), Edges).

dfs(Node, Graph, Visited, Reachable) ->
    if
        lists:member(Node, Visited) -> {Visited, Reachable};
        true -> 
            NewVisited = [Node | Visited],
            NewReachable = [Node | Reachable],
            Neighbors = maps:get(Node, Graph, []),
            lists:foldl(fun(Neighbor, Acc) -> dfs(Neighbor, Graph, NewVisited, Acc) end, {NewVisited, NewReachable}, Neighbors)
    end.

find_reverse_edges(Node, Graph) ->
    Neighbors = maps:get(Node, Graph, []),
    lists:length(lists:filter(fun(X) -> not lists:member(X, Neighbors) end, lists:seq(0, maps:size(Graph) - 1))).