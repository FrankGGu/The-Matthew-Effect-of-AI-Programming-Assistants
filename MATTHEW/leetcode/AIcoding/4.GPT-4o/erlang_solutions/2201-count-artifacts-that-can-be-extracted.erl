-module(solution).
-export([count_artifacts/2]).

count_artifacts(N, edges) ->
    Graph = build_graph(N, edges),
    {Count, _Visited} = dfs(Graph, N, 1, []),
    Count.

build_graph(N, Edges) ->
    Graph = lists:duplicate(N, []),
    lists:foldl(fun({X, Y}, Acc) ->
        update_graph(Acc, X, Y)
    end, Graph, Edges).

update_graph(Graph, X, Y) ->
    lists:update_element(X, lists:append(lists:nth(X, Graph), [Y]), Graph).

dfs(Graph, N, Node, Visited) ->
    if
        lists:member(Node, Visited) -> {0, Visited};
        true -> 
            NewVisited = [Node | Visited],
            Neighbors = lists:nth(Node, Graph),
            lists:foldl(fun(Neighbor, {Count, Vis}) ->
                dfs(Graph, N, Neighbor, Vis)
            end, {1, NewVisited}, Neighbors)
    end.