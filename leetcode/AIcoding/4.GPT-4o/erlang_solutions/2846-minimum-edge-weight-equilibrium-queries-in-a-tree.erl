-module(solution).
-export([min_edge_weight_equilibrium_queries/3]).

min_edge_weight_equilibrium_queries(N, Edges, Queries) ->
    Tree = build_tree(N, Edges),
    Weights = compute_weights(Tree),
    [find_min_weight(Weights, Path) || Path <- Queries].

build_tree(N, Edges) ->
    Lists = lists:foldl(fun({U, V, W}, Acc) ->
        maps:update_with(U, fun(L) -> [{V, W} | L] end, fun() -> [{V, W}] end, Acc),
        maps:update_with(V, fun(L) -> [{U, W} | L] end, fun() -> [{U, W}] end, Acc)
    end, maps:new(), Edges),
    Lists.

compute_weights(Tree) ->
    maps:map(fun(_, V) -> dfs(V, maps:remove(_, Tree), []) end, Tree).

dfs({Node, _Weight}, Tree, Visited) ->
    if
        lists:member(Node, Visited) -> []
    end;
    _ ->
        Neighbors = maps:get(Node, Tree, []),
        NewVisited = [Node | Visited],
        lists:flatmap(fun({Neighbor, Weight}) -> [(Node, Neighbor, Weight)] ++ dfs(Neighbor, maps:remove(Node, Tree), NewVisited) end, Neighbors)
end.

find_min_weight(Weights, Path) ->
    lists:min([Weight || {U, V, Weight} <- Weights, (U, V) = Path; (V, U) = Path]).