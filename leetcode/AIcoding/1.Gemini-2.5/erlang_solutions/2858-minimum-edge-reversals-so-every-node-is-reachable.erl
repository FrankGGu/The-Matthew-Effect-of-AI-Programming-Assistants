-module(solution).
-export([min_reversals/2]).

min_reversals(N, Edges) ->
    Graph = build_graph(N, Edges),

    {InitialRootCost, DownCostsMap} = dfs1(0, -1, Graph, #{}),

    TotalCostsMap0 = maps:put(0, InitialRootCost, #{}),
    TotalCostsMap = dfs2(0, -1, Graph, DownCostsMap, TotalCostsMap0),

    lists:min(maps:values(TotalCostsMap)).

build_graph(_N, Edges) ->
    lists:foldl(
        fun([U, V], Acc) ->
            Acc1 = maps:update_with(U, fun(List) -> [{V, 0} | List] end, [{V, 0}], Acc),
            maps:update_with(V, fun(List) -> [{U, 1} | List] end, [{U, 1}], Acc1)
        end,
        #{},
        Edges
    ).

dfs1(U, Parent, Graph, DownCostsAcc) ->
    Neighbors = maps:get(U, Graph, []),

    {SubtreeCost, FinalDownCostsAcc} = lists:foldl(
        fun({V, EdgeCost}, {AccCost, AccMap}) ->
            if V == Parent ->
                {AccCost, AccMap}
            else
                {ChildCost, UpdatedMap} = dfs1(V, U, Graph, AccMap),
                {AccCost + EdgeCost + ChildCost, UpdatedMap}
            end
        end,
        {0, DownCostsAcc},
        Neighbors
    ),

    {SubtreeCost, maps:put(U, SubtreeCost, FinalDownCostsAcc)}.

dfs2(U, Parent, Graph, _DownCostsMap, TotalCostsAcc) ->
    Neighbors = maps:get(U, Graph, []),

    lists:foldl(
        fun({V, EdgeCost}, AccMap) ->
            if V == Parent ->
                AccMap
            else
                CurrentTotalU = maps:get(U, AccMap),
                NewTotalV = CurrentTotalU - EdgeCost + (1 - EdgeCost),

                AccMap1 = maps:put(V, NewTotalV, AccMap),
                dfs2(V, U, Graph, _DownCostsMap, AccMap1)
            end
        end,
        TotalCostsAcc,
        Neighbors
    ).