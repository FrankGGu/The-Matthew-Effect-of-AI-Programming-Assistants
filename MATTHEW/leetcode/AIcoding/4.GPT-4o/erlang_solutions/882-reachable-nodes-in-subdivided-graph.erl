-module(solution).
-export([reachable_nodes/3]).

reachable_nodes(N, edges, limit) ->
    Graph = build_graph(N, edges),
    dfs(Graph, 0, 0, limit).

build_graph(N, Edges) ->
    Graph = lists:foldl(fun({A, B, C}, Acc) ->
        Map1 = maps:update_with(A, fun(X) -> X + C end, C, Acc),
        Map2 = maps:update_with(B, fun(X) -> X + C end, C, Map1),
        Map2
    end, maps:new(), Edges),
    Graph.

dfs(Graph, Node, Cost, Limit) ->
    if
        Cost > Limit -> 0;
        true -> 
            Neighbors = maps:get(Node, Graph, []),
            lists:foldl(fun({Neighbor, Weight}, Acc) ->
                if
                    Cost + Weight =< Limit -> 
                        Acc + dfs(Graph, Neighbor, Cost + Weight, Limit) + 1;
                    true -> 
                        Acc
                end
            end, 0, Neighbors)
    end.