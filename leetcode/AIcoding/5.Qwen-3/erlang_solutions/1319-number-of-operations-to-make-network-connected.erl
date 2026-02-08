-module(operations_to_make_network_connected).
-export([make_connected/2]).

make_connected(N, Connections) ->
    case length(Connections) < N - 1 of
        true -> -1;
        false ->
            Graph = build_graph(N, Connections),
            Visited = sets:new(),
            Count = count_components(Graph, Visited, 0),
            Count - 1
    end.

build_graph(N, Connections) ->
    lists:foldl(fun({A, B}, Acc) ->
                    Acc#{A => sets:add_element(B, maps:get(A, Acc, sets:new())),
                         B => sets:add_element(A, maps:get(B, Acc, sets:new()))}
                end, maps:new(), Connections).

count_components(Graph, Visited, Count) ->
    Nodes = lists:seq(0, N - 1),
    lists:foldl(fun(Node, C) ->
                    case sets:is_element(Node, Visited) of
                        true -> C;
                        false ->
                            {NewVisited, _} = dfs(Node, Graph, sets:add_element(Node, Visited)),
                            count_components(Graph, NewVisited, C + 1)
                    end
                end, Count, Nodes).

dfs(Node, Graph, Visited) ->
    Neighbors = maps:get(Node, Graph, sets:new()),
    lists:foldl(fun(Neighbor, V) ->
                    case sets:is_element(Neighbor, V) of
                        true -> V;
                        false -> dfs(Neighbor, Graph, sets:add_element(Neighbor, V))
                    end
                end, Visited, sets:to_list(Neighbors)).