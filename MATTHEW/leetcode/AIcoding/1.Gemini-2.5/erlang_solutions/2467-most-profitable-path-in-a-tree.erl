-module(solution).
-export([most_profitable_path/4]).

most_profitable_path(N, Edges, Bob, Amount) ->
    Adj = build_adj(N, Edges),
    BobTimes = get_bob_times(N, Adj, Bob),

    % Start Alice's DFS from node 0
    % dfs_alice(Node, Parent, CurrentTime, CurrentProfit, Adj, BobTimes, Amount, MaxProfitAcc)
    dfs_alice(0, -1, 0, 0, Adj, BobTimes, Amount, -2000000000000000000). % Use a sufficiently small number for initial max profit

build_adj(N, Edges) ->
    lists:foldl(
        fun([U, V], Acc) ->
            Acc1 = maps:update_with(U, fun(L) -> [V | L] end, [V], Acc),
            maps:update_with(V, fun(L) -> [U | L] end, [U], Acc1)
        end,
        maps:from_list([{I, []} || I <- lists:seq(0, N-1)]), % Initialize all nodes with empty lists
        Edges
    ).

get_bob_times(N, Adj, Bob) ->
    % BFS to find parent pointers from node 0 to all reachable nodes
    Parents = array:new(N, {default, -1}), % Parent array, -1 indicates no parent
    Queue = queue:new(),
    Visited = array:new(N, {default, false}),

    Queue1 = queue:in({0, -1}, Queue), % {Node, Parent}
    Visited1 = array:set(0, true, Visited),

    {_FinalQueue, _FinalVisited, FinalParents} = bfs_parents(Queue1, Adj, Visited1, Parents),

    % Reconstruct Bob's path from Bob to 0 using parent pointers
    BobPath = reconstruct_path(Bob, FinalParents), % Path from Bob to 0

    % Record Bob's arrival times for nodes on his path
    lists:foldl(
        fun(Node, {Time, AccMap}) ->
            {Time + 1, maps:put(Node, Time, AccMap)}
        end,
        {0, #{}}, % Initial time 0, empty map
        BobPath
    ) |> element(2). % Extract the map

bfs_parents(Queue, Adj, Visited, Parents) ->
    case queue:out(Queue) of
        {{value, {Node, Parent}}, RestQueue} ->
            NewParents = array:set(Node, Parent, Parents),
            Neighbors = maps:get(Node, Adj, []),

            % Process neighbors, updating Queue and Visited
            {NextQueue, NextVisited} = lists:foldl(
                fun(Neighbor, {QAcc, VAcc}) ->
                    case array:get(Neighbor, VAcc) of
                        false ->
                            {queue:in({Neighbor, Node}, QAcc), array:set(Neighbor, true, VAcc)};
                        true ->
                            {QAcc, VAcc}
                    end
                end,
                {RestQueue, Visited}, % Use the RestQueue and current Visited for foldl
                Neighbors
            ),
            bfs_parents(NextQueue, Adj, NextVisited, NewParents);
        {empty, _RestQueue} ->
            {Queue, Visited, Parents} % Return final states
    end.

reconstruct_path(CurrentNode, Parents) ->
    reconstruct_path_acc(CurrentNode, Parents, []).

reconstruct_path_acc(-1, _Parents, Acc) -> Acc; % Base case: reached root's parent
reconstruct_path_acc(CurrentNode, Parents, Acc) ->
    Parent = array:get(CurrentNode, Parents),
    reconstruct_path_acc(Parent, Parents, [CurrentNode | Acc]).

dfs_alice(Node, Parent, CurrentTime, CurrentProfit, Adj, BobTimes, Amount, MaxProfitAcc) ->
    % Calculate profit for the current node based on Alice's and Bob's arrival times
    BobArrivalTime = maps:get(Node, BobTimes, 2000000000), % If Bob doesn't visit, his time is effectively infinite
    NodeAmount = lists:nth(Node + 1, Amount), % Amount list is 1-indexed for lists:nth

    ProfitToAdd = 
        if
            CurrentTime < BobArrivalTime -> NodeAmount;
            CurrentTime == BobArrivalTime -> NodeAmount div 2;
            true -> 0 % CurrentTime > BobArrivalTime
        end,

    NewCurrentProfit = CurrentProfit + ProfitToAdd,

    Neighbors = maps:get(Node, Adj, []),
    ValidNeighbors = lists:filter(fun(N) -> N /= Parent end, Neighbors), % Exclude parent to avoid going back

    case ValidNeighbors of
        [] -> % Leaf node (or node 0 if it has no other neighbors)
            max(MaxProfitAcc, NewCurrentProfit);
        _ -> % Not a leaf node, continue DFS
            lists:foldl(
                fun(Child, Acc) ->
                    dfs_alice(Child, Node, CurrentTime + 1, NewCurrentProfit, Adj, BobTimes, Amount, Acc)
                end,
                MaxProfitAcc,
                ValidNeighbors
            )
    end.