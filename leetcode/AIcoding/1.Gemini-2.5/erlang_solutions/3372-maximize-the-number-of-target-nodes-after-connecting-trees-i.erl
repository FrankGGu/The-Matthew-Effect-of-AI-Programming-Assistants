-module(solution).
-export([max_targets_after_connecting_trees/3]).

max_targets_after_connecting_trees(N, Edges, TargetNodes) ->
    Adj = build_adj_list(N, Edges),
    TargetSet = sets:from_list(TargetNodes),

    {_, ComponentTargetCounts} = find_components(N, Adj, TargetSet),

    case ComponentTargetCounts of
        [] -> 0; % No nodes, no targets
        [C] -> C; % Only one component, cannot connect two, so take its targets
        _ ->
            % Sort counts in descending order and sum the top two
            SortedCounts = lists:sort(fun(A, B) -> A >= B end, ComponentTargetCounts),
            lists:nth(1, SortedCounts) + lists:nth(2, SortedCounts)
    end.

build_adj_list(N, Edges) ->
    Adj = maps:new(),
    lists:foldl(fun([U, V], Acc) ->
        Acc1 = maps:update_with(U, fun(List) -> [V | List] end, [V], Acc),
        maps:update_with(V, fun(List) -> [U | List] end, [U], Acc1)
    end, Adj, Edges).

find_components(N, Adj, TargetSet) ->
    Visited = sets:new(),
    ComponentTargetCounts = [],
    find_components_recursive(0, N, Adj, TargetSet, Visited, ComponentTargetCounts).

find_components_recursive(Node, N, Adj, TargetSet, Visited, ComponentTargetCountsAcc) when Node < N ->
    case sets:is_element(Node, Visited) of
        true ->
            find_components_recursive(Node + 1, N, Adj, TargetSet, Visited, ComponentTargetCountsAcc);
        false ->
            % Start a new BFS/DFS from this unvisited node
            {NewVisited, TargetCount} = bfs(Node, Adj, TargetSet, Visited),
            find_components_recursive(Node + 1, N, Adj, TargetSet, NewVisited, [TargetCount | ComponentTargetCountsAcc])
    end;
find_components_recursive(N, _N, _Adj, _TargetSet, Visited, ComponentTargetCountsAcc) ->
    {Visited, ComponentTargetCountsAcc}.

bfs(StartNode, Adj, TargetSet, Visited) ->
    Queue = queue:in(StartNode, queue:new()),
    Visited1 = sets:add_element(StartNode, Visited),
    TargetCount = if sets:is_element(StartNode, TargetSet) -> 1; true -> 0 end,
    bfs_loop(Queue, Adj, TargetSet, Visited1, TargetCount).

bfs_loop(Queue, Adj, TargetSet, Visited, TargetCountAcc) ->
    case queue:out(Queue) of
        {{value, CurrentNode}, RestQueue} ->
            Neighbors = maps:get(CurrentNode, Adj, []), % Get neighbors, default to empty list if node not in map
            {NewQueue, NewVisited, NewTargetCountAcc} =
                lists:foldl(fun(Neighbor, {QAcc, VAcc, TAcc}) ->
                    case sets:is_element(Neighbor, VAcc) of
                        true ->
                            {QAcc, VAcc, TAcc};
                        false ->
                            VAcc1 = sets:add_element(Neighbor, VAcc),
                            QAcc1 = queue:in(Neighbor, QAcc),
                            TAcc1 = if sets:is_element(Neighbor, TargetSet) -> TAcc + 1; true -> TAcc end,
                            {QAcc1, VAcc1, TAcc1}
                    end
                end, {RestQueue, Visited, TargetCountAcc}, Neighbors),
            bfs_loop(NewQueue, Adj, TargetSet, NewVisited, NewTargetCountAcc);
        empty ->
            {Visited, TargetCountAcc}
    end.