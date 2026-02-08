-module(solution).
-export([min_operations_queries/3]).

min_operations_queries(N, Edges, Queries) ->
    Tree = build_tree(N, Edges),
    Parent = array:new([{size, N}, {default, -1}]),
    Depth = array:new([{size, N}, {default, 0}]),
    WeightCounts = array:new([{size, N}, {default, maps:new()}]),
    {Parent1, Depth1, WeightCounts1} = dfs(0, -1, 0, Tree, Parent, Depth, WeightCounts),
    process_queries(Queries, Parent1, Depth1, WeightCounts1).

build_tree(N, Edges) ->
    Tree = array:new([{size, N}, {default, []}]),
    lists:foldl(fun([U, V, W], Acc) ->
        Neighbors = array:get(U, Acc),
        array:set(U, [{V, W} | Neighbors], Acc)
    end, Tree, Edges).

dfs(Node, ParentNode, CurrentDepth, Tree, Parent, Depth, WeightCounts) ->
    Parent1 = array:set(Node, ParentNode, Parent),
    Depth1 = array:set(Node, CurrentDepth, Depth),
    Neighbors = array:get(Node, Tree),
    {Parent2, Depth2, WeightCounts2} = 
        lists:foldl(fun({Child, W}, {P, D, WC}) ->
            if Child =/= ParentNode ->
                ChildWC = maps:update_with(W, fun(C) -> C + 1 end, 1, array:get(Node, WC)),
                WC1 = array:set(Child, ChildWC, WC),
                dfs(Child, Node, CurrentDepth + 1, Tree, P, D, WC1);
            true -> {P, D, WC}
            end
        end, {Parent1, Depth1, WeightCounts}, Neighbors),
    {Parent2, Depth2, WeightCounts2}.

process_queries(Queries, Parent, Depth, WeightCounts) ->
    lists:map(fun([U, V]) ->
        {LCA, PathLength, PathWeights} = find_lca_and_path(U, V, Parent, Depth, WeightCounts),
        TotalWeights = maps:fold(fun(K, V, Sum) -> Sum + V end, 0, PathWeights),
        MaxWeight = case maps:size(PathWeights) of
            0 -> 0;
            _ -> lists:max(maps:values(PathWeights))
        end,
        PathLength - MaxWeight
    end, Queries).

find_lca_and_path(U, V, Parent, Depth, WeightCounts) ->
    {U1, V1} = if array:get(U, Depth) > array:get(V, Depth) -> {V, U}; true -> {U, V} end,
    Diff = array:get(V1, Depth) - array:get(U1, Depth),
    {V2, PathWeights1} = lift(V1, Diff, Parent, WeightCounts, maps:new()),
    {LCA, PathWeights} = find_lca(U1, V2, Parent, WeightCounts, PathWeights1),
    PathLength = array:get(U, Depth) + array:get(V, Depth) - 2 * array:get(LCA, Depth),
    {LCA, PathLength, PathWeights}.

lift(Node, 0, _, _, Weights) -> {Node, Weights};
lift(Node, K, Parent, WeightCounts, Weights) ->
    P = array:get(Node, Parent),
    W = maps:iterator(array:get(Node, WeightCounts)),
    Weights1 = maps:merge(Weights, W),
    lift(P, K - 1, Parent, WeightCounts, Weights1).

find_lca(U, V, Parent, WeightCounts, Weights) ->
    if U =:= V -> {U, Weights};
    true ->
        PU = array:get(U, Parent),
        PV = array:get(V, Parent),
        WU = maps:iterator(array:get(U, WeightCounts)),
        WV = maps:iterator(array:get(V, WeightCounts)),
        Weights1 = maps:merge(Weights, WU),
        Weights2 = maps:merge(Weights1, WV),
        find_lca(PU, PV, Parent, WeightCounts, Weights2)
    end.