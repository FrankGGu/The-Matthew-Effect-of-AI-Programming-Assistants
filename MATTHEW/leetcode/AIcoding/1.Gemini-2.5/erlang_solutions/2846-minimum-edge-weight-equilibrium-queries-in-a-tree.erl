-module(solution).
-export([minEdgeWeightQueries/3]).

-define(MAX_NODES, 10001). % N up to 10^4, nodes are 1-indexed.
-define(MAX_WEIGHT, 26).  % Weights 1 to 26.
-define(MAX_LOG, 15).     % ceil(log2(10000)) = 14. Add 1 for safety.

minEdgeWeightQueries(N, Edges, Queries) ->
    Adj = build_adj(N, Edges),

    DepthArr = array:new([{size, N + 1}, {default, -1}]),
    ParentArr = array:new([{size, N + 1}, {default, array:new([{size, ?MAX_LOG}, {default, 0}])}]),
    PathCountsArr = array:new([{size, N + 1}, {default, array:new([{size, ?MAX_WEIGHT}, {default, 0}])}]),

    InitialState = #{
        adj => Adj,
        depth => DepthArr,
        parent => ParentArr,
        path_counts => PathCountsArr
    },

    RootPathCounts = array:new([{size, ?MAX_WEIGHT}, {default, 0}]),
    DFSState = dfs(1, 0, 0, RootPathCounts, InitialState),

    FinalState = build_binary_lifting(N, DFSState),

    process_queries(Queries, FinalState).

build_adj(N, Edges) ->
    lists:foldl(
        fun([U, V, W], Acc) ->
            maps:update_with(U, fun(L) -> [{V, W} | L] end, [{V, W}], Acc),
            maps:update_with(V, fun(L) -> [{U, W} | L] end, [{U, W}], Acc)
        end,
        maps:new(),
        Edges
    ).

dfs(Node, Parent, Depth, CurrentNodePathCounts, State) ->
    Adj = maps:get(adj, State),

    DepthArr = maps:get(depth, State),
    ParentArr = maps:get(parent, State),
    PathCountsArr = maps:get(path_counts, State),

    NewDepthArr = array:set(Node, Depth, DepthArr),

    NodeParentArr = array:set(0, Parent, array:get(Node, ParentArr)),
    NewParentArr = array:set(Node, NodeParentArr, ParentArr),

    NewPathCountsArr = array:set(Node, CurrentNodePathCounts, PathCountsArr),

    UpdatedState = State#{
        depth := NewDepthArr,
        parent := NewParentArr,
        path_counts := NewPathCountsArr
    },

    Neighbors = maps:get(Node, Adj, []),
    lists:foldl(
        fun({Neighbor, Weight}, AccState) ->
            if Neighbor == Parent -> AccState;
               true ->
                    UpdatedChildPathCounts = array:set(Weight - 1, array:get(Weight - 1, CurrentNodePathCounts) + 1, CurrentNodePathCounts),
                    dfs(Neighbor, Node, Depth + 1, UpdatedChildPathCounts, AccState)
            end
        end,
        UpdatedState,
        Neighbors
    ).

build_binary_lifting(N, State) ->
    ParentArr = maps:get(parent, State),

    NewParentArr = lists:foldl(
        fun(K, CurrentParentArr) ->
            lists:foldl(
                fun(Node, AccParentArr) ->
                    Parent_2_K_minus_1 = array:get(K - 1, array:get(Node, AccParentArr)),
                    Grandparent_2_K_minus_1 = array:get(K - 1, array:get(Parent_2_K_minus_1, AccParentArr)),

                    NodeParentKArr = array:get(Node, AccParentArr),
                    UpdatedNodeParentKArr = array:set(K, Grandparent_2_K_minus_1, NodeParentKArr),
                    array:set(Node, UpdatedNodeParentKArr, AccParentArr)
                end,
                CurrentParentArr,
                lists:seq(1, N)
            )
        end,
        ParentArr,
        lists:seq(1, ?MAX_LOG - 1)
    ),
    State#{parent := NewParentArr}.

get_lca(U, V, State) ->
    DepthArr = maps:get(depth, State),
    ParentArr = maps:get(parent, State),

    DepthU = array:get(U, DepthArr),
    DepthV = array:get(V, DepthArr),

    {U1, V1} = if DepthU < DepthV -> {V, U};
                 true -> {U, V}
               end,

    LiftedU1 = lift_node(U1, abs(DepthU - DepthV), ParentArr),

    if LiftedU1 == V1 -> V1;
       true ->
            LCA_Candidate = lists:foldr(
                fun(K, CurrentNode) ->
                    ParentA = array:get(K, array:get(CurrentNode, ParentArr)),
                    ParentB = array:get(K, array:get(V1, ParentArr)),
                    if ParentA /= ParentB -> ParentA;
                       true -> CurrentNode
                    end
                end,
                LiftedU1,
                lists:seq(?MAX_LOG - 1, 0, -1)
            ),
            array:get(0, array:get(LCA_Candidate, ParentArr))
    end.

lift_node(Node, K, ParentArr) ->
    lists:foldr(
        fun(I, CurrentNode) ->
            if (K band (1 bsl I)) /= 0 ->
                array:get(I, array:get(CurrentNode, ParentArr));
            true ->
                CurrentNode
            end
        end,
        Node,
        lists:seq(?MAX_LOG - 1, 0, -1)
    ).

process_queries(Queries, State) ->
    lists:map(
        fun([U, V]) ->
            LCA = get_lca(U, V, State),
            calculate_min_changes(U, V, LCA, State)
        end,
        Queries
    ).

calculate_min_changes(U, V, LCA, State) ->
    DepthArr = maps:get(depth, State),
    PathCountsArr = maps:get(path_counts, State),

    DepthU = array:get(U, DepthArr),
    DepthV = array:get(V, DepthArr),
    DepthLCA = array:get(LCA, DepthArr),

    TotalEdgesOnPath = DepthU + DepthV - 2 * DepthLCA,

    if TotalEdgesOnPath == 0 -> 0;
       true ->
            MinChanges = lists:foldl(
                fun(W, CurrentMin) ->
                    CountU_W = array:get(W - 1, array:get(U, PathCountsArr)),
                    CountV_W = array:get(W - 1, array:get(V, PathCountsArr)),
                    CountLCA_W = array:get(W - 1, array:get(LCA, PathCountsArr)),

                    CountOnPath_W = CountU_W + CountV_W - 2 * CountLCA_W,

                    Changes = TotalEdgesOnPath - CountOnPath_W,
                    min(CurrentMin, Changes)
                end,
                TotalEdgesOnPath,
                lists:seq(1, ?MAX_WEIGHT)
            ),
            MinChanges
    end.