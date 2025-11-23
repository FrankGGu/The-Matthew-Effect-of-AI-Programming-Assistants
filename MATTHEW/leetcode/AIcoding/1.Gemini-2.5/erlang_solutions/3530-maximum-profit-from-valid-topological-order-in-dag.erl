-module(solution).
-export([max_profit_from_valid_topological_order/3]).

max_profit_from_valid_topological_order(N, Profits, Dependencies) ->
    % Convert Profits list to a map for O(1) access
    ProfitsMap = lists:foldl(fun({Idx, Profit}, Acc) -> maps:put(Idx, Profit, Acc) end, #{}, lists:zip(lists:seq(0, N-1), Profits)),

    % Initialize Adj (adjacency list) and InDegree maps
    Adj = maps:new(),
    InDegree = maps:new(),

    % Populate Adj and InDegree from Dependencies
    {FinalAdj, FinalInDegree} = lists:foldl(
        fun([U, V], {CurrentAdj, CurrentInDegree}) ->
            NewAdj = maps:update_with(U, fun(List) -> [V | List] end, [V], CurrentAdj),
            NewInDegree = maps:update_with(V, fun(Count) -> Count + 1 end, 1, CurrentInDegree),
            {NewAdj, NewInDegree}
        end,
        {Adj, InDegree},
        Dependencies
    ),

    % Ensure all nodes are present in Adj (with empty list if no outgoing edges)
    % and InDegree (with 0 if no incoming edges)
    AdjWithAllNodes = lists:foldl(fun(I, Acc) -> maps:put_new(I, [], Acc) end, FinalAdj, lists:seq(0, N-1)),
    InDegreeWithAllNodes = lists:foldl(fun(I, Acc) -> maps:put_new(I, 0, Acc) end, FinalInDegree, lists:seq(0, N-1)),

    % Initialize DP table (max profit ending at node I) and queue for topological sort
    DP = maps:new(),
    Queue = queue:new(),

    {InitialDP, InitialQueue} = lists:foldl(
        fun(I, {CurrentDP, CurrentQueue}) ->
            ProfitI = maps:get(I, ProfitsMap),
            NewDP = maps:put(I, ProfitI, CurrentDP), % Initial DP value for each node is its own profit
            NodeInDegree = maps:get(I, InDegreeWithAllNodes),
            If
                NodeInDegree == 0 -> % Add source nodes to the queue
                    NewQueue = queue:in(I, CurrentQueue);
                true ->
                    NewQueue = CurrentQueue
            End,
            {NewDP, NewQueue}
        end,
        {DP, Queue},
        lists:seq(0, N-1)
    ),

    % Start the topological sort and DP calculation
    % CurrentMaxProfit tracks the overall maximum profit found across all paths
    kahn_dp_loop(InitialQueue, InitialDP, InDegreeWithAllNodes, 0, ProfitsMap, AdjWithAllNodes).

kahn_dp_loop(Queue, DP, InDegree, CurrentMaxProfit, ProfitsMap, Adj) ->
    case queue:out(Queue) of
        {empty, _} ->
            CurrentMaxProfit; % No more nodes to process, return the max profit found
        {value, U, NewQueue} ->
            % Update overall max profit with the profit ending at node U
            MaxProfitAfterU = max(CurrentMaxProfit, maps:get(U, DP)),

            Neighbors = maps:get(U, Adj, []), % Get direct successors of U

            % Process each neighbor V of U
            {UpdatedQueue, UpdatedDP, UpdatedInDegree} = lists:foldl(
                fun(V, {QAcc, DAcc, IDCAcc}) ->
                    % Calculate new DP value for V:
                    % Max of current DP[V] or path through U (DP[U] + Profit[V])
                    NewDP_V = max(maps:get(V, DAcc), maps:get(U, DAcc) + maps:get(V, ProfitsMap)),
                    NewDAcc = maps:put(V, NewDP_V, DAcc),

                    % Decrement in-degree for V
                    NewInDegree_V = maps:get(V, IDCAcc) - 1,
                    NewIDCAcc = maps:put(V, NewInDegree_V, IDCAcc),

                    % If in-degree of V becomes 0, add V to the queue
                    If
                        NewInDegree_V == 0 ->
                            NewQAcc = queue:in(V, QAcc);
                        true ->
                            NewQAcc = QAcc
                    End,
                    {NewQAcc, NewDAcc, NewIDCAcc}
                end,
                {NewQueue, DP, InDegree}, % Initial accumulators for foldl
                Neighbors
            ),
            % Continue the loop with updated state
            kahn_dp_loop(UpdatedQueue, UpdatedDP, UpdatedInDegree, MaxProfitAfterU, ProfitsMap, Adj)
    end.