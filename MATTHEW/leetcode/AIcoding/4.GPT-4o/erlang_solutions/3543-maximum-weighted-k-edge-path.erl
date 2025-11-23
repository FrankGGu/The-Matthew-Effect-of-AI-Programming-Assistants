-module(solution).
-export([max_weighted_k_edge_path/3]).

max_weighted_k_edge_path/3(K, Edges, Nodes) ->
    Graph = build_graph(Edges, Nodes),
    max_path_weight(Graph, K, Nodes).

build_graph(Edges, Nodes) ->
    lists:foldl(fun({U, V, W}, Acc) -> 
        maps:update_with(U, fun(X) -> X ++ [{V, W}] end, fun() -> [{V, W}] end, Acc) 
        end, 
        lists:map(fun(N) -> {N, []} end, Nodes) |> maps:from_list,
        Edges).

max_path_weight(Graph, K, Nodes) ->
    lists:max(lists:map(fun(Node) -> dfs(Graph, Node, K, maps:keys(Graph), 0) end, Nodes)).

dfs(_, _, 0, _, Acc) -> Acc;
dfs(Graph, Node, K, Visited, Acc) ->
    case maps:get(Node, Graph) of
        [] -> Acc;
        Edges ->
            lists:max(
                lists:map(fun({Next, Weight}) ->
                    if 
                        lists:member(Next, Visited) ->
                            Acc;
                        true ->
                            dfs(Graph, Next, K - 1, [Node | Visited], Acc + Weight)
                    end
                end, Edges) ++ [Acc]
            )
    end.