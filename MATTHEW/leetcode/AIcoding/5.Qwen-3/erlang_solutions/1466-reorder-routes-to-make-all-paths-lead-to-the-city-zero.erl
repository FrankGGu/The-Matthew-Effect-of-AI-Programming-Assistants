-module(reorder_routes).
-export([minReorder/2]).

minReorder(N, Connections) ->
    Graph = build_graph(N, Connections),
    visited = array:new(N, {default, false}),
    count = 0,
    dfs(0, -1, Graph, visited, count).

build_graph(N, Connections) ->
    Graph = array:new(N, {default, []}),
    lists:foreach(fun({A, B}) ->
        Graph1 = array:set(A, [B | array:get(A, Graph)], Graph),
        Graph2 = array:set(B, [A | array:get(B, Graph)], Graph),
        Graph = Graph2
    end, Connections),
    Graph.

dfs(Node, Parent, Graph, Visited, Count) ->
    case array:get(Node, Visited) of
        true -> Count;
        _ ->
            Visited1 = array:set(Node, true, Visited),
            Children = array:get(Node, Graph),
            lists:foldl(fun(Child, Acc) ->
                if
                    Child /= Parent ->
                        case lists:member(Node, array:get(Child, Graph)) of
                            true ->
                                dfs(Child, Node, Graph, Visited1, Acc);
                            false ->
                                dfs(Child, Node, Graph, Visited1, Acc + 1)
                        end;
                    true ->
                        Acc
                end
            end, Count, Children).