-module(solution).
-export([criticalConnections/2]).

criticalConnections(N, Connections) ->
    Adj = build_adj_list(N, Connections),

    % Initial state for DFS:
    % DiscMap: Map of node -> discovery time
    % LowMap: Map of node -> lowest reachable discovery time
    % Time: Global time counter for discovery times
    % Bridges: List of critical connections found
    DiscMap0 = maps:new(),
    LowMap0 = maps:new(),
    Time0 = 0,
    Bridges0 = [],

    InitialState = {DiscMap0, LowMap0, Time0, Bridges0},

    % Iterate through all nodes to handle potentially disconnected graphs.
    % For each unvisited node, start a DFS.
    % The state (DiscMap, LowMap, Time, Bridges) is passed and updated across DFS calls.
    {_FinalDiscMap, _FinalLowMap, _FinalTime, FinalBridges} =
        lists:foldl(fun(Node, {CurrentDiscMap, CurrentLowMap, CurrentTime, CurrentBridges}) ->
            if not maps:is_key(Node, CurrentDiscMap) ->
                % If node is not visited, start a new DFS from it
                dfs(Node, -1, Adj, CurrentDiscMap, CurrentLowMap, CurrentTime, CurrentBridges);
            true ->
                % Node already visited, continue with current state
                {CurrentDiscMap, CurrentLowMap, CurrentTime, CurrentBridges}
            end
        end, InitialState, lists:seq(0, N - 1)),

    FinalBridges.

build_adj_list(N, Connections) ->
    % Initialize adjacency list with all nodes having empty lists.
    % This ensures that even isolated nodes are present as keys in the map.
    InitialAdj = lists:foldl(fun(I, Acc) -> maps:put(I, [], Acc) end, maps:new(), lists:seq(0, N - 1)),

    % Populate adjacency list with connections
    lists:foldl(fun([U, V], Acc) ->
        maps:update_with(U, fun(L) -> [V | L] end, Acc),
        maps:update_with(V, fun(L) -> [U | L] end, Acc)
    end, InitialAdj, Connections).

dfs(U, Parent, Adj, DiscMap0, LowMap0, Time0, Bridges0) ->
    % Increment time and set discovery time (disc) and low-link value (low) for U
    Time1 = Time0 + 1,
    DiscMap1 = maps:put(U, Time1, DiscMap0),
    LowMap1 = maps:put(U, Time1, LowMap0), % Initialize low[U] with disc[U]

    % Fold over neighbors of U to explore the graph
    % AccState = {CurrentDiscMap, CurrentLowMap, CurrentTime, CurrentBridgesList}
    {FinalDiscMap, FinalLowMap, FinalTime, FinalBridges} = 
        lists:foldl(fun(V, {CurrentDiscMap, CurrentLowMap, CurrentTime, CurrentBridgesList}) ->
            if V == Parent ->
                % If V is the parent of U, skip (don't traverse back up the DFS tree)
                {CurrentDiscMap, CurrentLowMap, CurrentTime, CurrentBridgesList};
            true ->
                % If V is already visited (has a discovery time)
                if maps:is_key(V, CurrentDiscMap) ->
                    % This is a back-edge to an ancestor or a cross-edge to an already processed node.
                    % Update low[U] with disc[V] (if V is an ancestor, it forms a cycle).
                    UpdatedLowMap = maps:update_with(U, fun(Val) -> min(Val, maps:get(V, CurrentDiscMap)) end, CurrentLowMap),
                    {CurrentDiscMap, UpdatedLowMap, CurrentTime, CurrentBridgesList};
                true ->
                    % V is not visited, recursively call DFS on V
                    % Pass the current state from the fold accumulator to the recursive call
                    {NextDiscMap, NextLowMap, NextTime, NextBridgesList} = 
                        dfs(V, U, Adj, CurrentDiscMap, CurrentLowMap, CurrentTime, CurrentBridgesList),

                    % After DFS(V) returns, update low[U] based on low[V]
                    % The low value for U (maps:get(U, CurrentLowMap)) is compared with low[V] (maps:get(V, NextLowMap)).
                    UpdatedLowMapU = maps:update_with(U, fun(Val) -> min(Val, maps:get(V, NextLowMap)) end, CurrentLowMap),

                    % Check for bridge condition: if low[V] > disc[U], then (U, V) is a bridge.
                    % disc[U] is maps:get(U, DiscMap1) (set at the beginning of this U's DFS call).
                    % low[V] is maps:get(V, NextLowMap) (the lowest reachable time from V's subtree).
                    UpdatedBridges = if maps:get(V, NextLowMap) > maps:get(U, DiscMap1) ->
                                        [[U, V] | NextBridgesList];
                                     true ->
                                        NextBridgesList
                                     end,

                    % Return the updated state for the next iteration of foldl.
                    % DiscMap and Time are updated by the recursive call for V's subtree.
                    % LowMap for U is updated (UpdatedLowMapU).
                    % Bridges are updated (UpdatedBridges).
                    {NextDiscMap, UpdatedLowMapU, NextTime, UpdatedBridges}
                end
            end
        end, {DiscMap1, LowMap1, Time1, Bridges0}, maps:get(U, Adj, [])), % Initial state for foldl is after U itself is processed

    {FinalDiscMap, FinalLowMap, FinalTime, FinalBridges}.