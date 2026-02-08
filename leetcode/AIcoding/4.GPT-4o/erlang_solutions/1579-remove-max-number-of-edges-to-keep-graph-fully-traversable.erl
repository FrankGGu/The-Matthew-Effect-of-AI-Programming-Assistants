-module(solution).
-export([max_edges_to_remove/3]).

max_edges_to_remove(N, E, Edges) ->
    {Graph1, Graph2} = build_graphs(N, Edges),
    {C1, C2} = {connected_components(Graph1), connected_components(Graph2)},
    TotalEdges = length(Edges),
    can_form_tree(C1, N - 1) + can_form_tree(C2, N - 1) - (C1 + C2 - 1).

build_graphs(N, Edges) ->
    Graph1 = lists:foldl(fun({t, u}, Acc) -> add_edge(Acc, t, u); ({u, t}, Acc) -> add_edge(Acc, u, t) end, lists:duplicate(N, []), Edges),
    Graph2 = lists:foldl(fun({r, u}, Acc) -> add_edge(Acc, r, u); ({u, r}, Acc) -> add_edge(Acc, u, r) end, lists:duplicate(N, []), Edges),
    {Graph1, Graph2}.

add_edge(Graph, U, V) ->
    lists:map(fun({K, VList}) -> if K =:= U -> {K, [V | VList]}; true -> {K, VList} end end, lists:zip(lists:seq(1, length(Graph)), Graph)).

connected_components(Graph) ->
    lists:foldl(fun({Node, Visited}, Acc) -> if lists:member(Node, Visited) -> Acc; true -> length(dfs(Node, Graph, Visited)) + Acc end end, 0, lists:zip(lists:seq(1, length(Graph)), Graph)).

dfs(Node, Graph, Visited) ->
    lists:foldl(fun(Neigh, Acc) -> if lists:member(Neigh, Acc) -> Acc; true -> dfs(Neigh, Graph, [Neigh | Acc]) end end, [Node], Graph).

can_form_tree(Count, Edges) -> if Count - 1 <= Edges -> Count - 1; true -> 0 end.