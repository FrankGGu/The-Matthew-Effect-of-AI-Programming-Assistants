-module(solution).
-export([max_targets_after_connecting_trees/4]).

max_targets_after_connecting_trees(N, Edges, TargetNodes, K) ->
    Adj = build_adj_list(N, Edges),
    TargetSet = gb_sets:from_list(TargetNodes),

    InitialVisited = array:new([{size, N}, {fixed, true}, {default, false}]),
    {ComponentTargets, _FinalVisited} = find_components(N, Adj, TargetSet, InitialVisited, 0, []),

    SortedComponentTargets = lists:sort(fun(A, B) -> A >= B end, ComponentTargets),

    NumComponents = length(SortedComponentTargets),
    NumComponentsToConnect = min(NumComponents, K + 1),

    sum_top_n(SortedComponentTargets, NumComponentsToConnect, 0).

build_adj_list(N, Edges) ->
    Adj = array:new([{size, N}, {fixed, true}, {default, []}]),
    lists:foldl(fun([U, V], Acc) ->
        Acc1 = array:set(U, [V | array:get(U, Acc)], Acc),
        array:set(V, [U | array:get(V, Acc1)], Acc1)
    end, Adj, Edges).

find_components(N, Adj, TargetSet, Visited, Node, Acc) ->
    if Node >= N ->
        {Acc, Visited};
    true ->
        case array:get(Node, Visited) of
            true ->
                find_components(N, Adj, TargetSet, Visited, Node + 1, Acc);
            false ->
                {ComponentTargetCount, NewVisited} = dfs(Adj, TargetSet, Visited, Node),
                find_components(N, Adj, TargetSet, NewVisited, Node + 1, [ComponentTargetCount | Acc])
        end
    end.

dfs(Adj, TargetSet, Visited, CurrentNode) ->
    Visited1 = array:set(CurrentNode, true, Visited),

    Count = if gb_sets:is_member(CurrentNode, TargetSet) -> 1; true -> 0 end,

    Neighbors = array:get(CurrentNode, Adj),
    lists:foldl(fun(Neighbor, {AccCount, AccVisited}) ->
        case array:get(Neighbor, AccVisited) of
            true ->
                {AccCount, AccVisited};
            false ->
                {NeighborCount, NeighborVisited} = dfs(Adj, TargetSet, AccVisited, Neighbor),
                {AccCount + NeighborCount, NeighborVisited}
        end
    end, {Count, Visited1}, Neighbors).

sum_top_n([], _, Sum) -> Sum;
sum_top_n(_, 0, Sum) -> Sum;
sum_top_n([H | T], N, Sum) ->
    sum_top_n(T, N - 1, Sum + H).