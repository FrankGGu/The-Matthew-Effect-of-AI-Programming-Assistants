-module(solution).
-export([collectCoins/3]).

collectCoins(N, Coins, Edges) ->
    % Build adjacency list
    % AdjList is an array where AdjList[i] contains a list of neighbors of node i.
    Adj = array:new([{size, N}, {fixed, true}, {default, []}]),
    Adj1 = lists:foldl(
        fun([U, V], Acc) ->
            Acc1 = array:set(U, [V | array:get(U, Acc)], Acc),
            array:set(V, [U | array:get(V, Acc1)], Acc1)
        end,
        Adj,
        Edges
    ),
    AdjList = array:to_list(Adj1),

    % Initialize nodes_to_keep set, queue for BFS, and visited set
    NodesToKeep = sets:new(),
    Q = queue:new(),
    Visited = sets:new(),

    % Add all coin nodes to the queue with distance 0
    InitialQ = lists:foldl(
        fun(I, AccQ) ->
            case lists:nth(I + 1, Coins) of % Coins is 0-indexed, lists:nth is 1-indexed
                1 ->
                    queue:in({I, 0}, AccQ);
                _ ->
                    AccQ
            end
        end,
        Q,
        lists:seq(0, N - 1)
    ),

    % Perform BFS to find all nodes that must be kept
    % These are coin nodes and nodes within 2 steps of a coin node.
    FinalNodesToKeep = bfs(InitialQ, AdjList, Visited, NodesToKeep),

    % Count the number of edges between the kept nodes
    % Each edge (U,V) will be counted twice (once from U, once from V), so divide by 2.
    TotalEdges = count_edges(0, N - 1, AdjList, FinalNodesToKeep),
    TotalEdges div 2.

bfs(Q, AdjList, Visited, NodesToKeep) ->
    case queue:out(Q) of
        {{value, {U, Dist}}, RestQ} ->
            case sets:is_element(U, Visited) of
                true ->
                    % Node U already visited, skip
                    bfs(RestQ, AdjList, Visited, NodesToKeep);
                false ->
                    % Mark U as visited and add to nodes_to_keep
                    NewVisited = sets:add_element(U, Visited),
                    NewNodesToKeep = sets:add_element(U, NodesToKeep),

                    % If distance is less than 2, explore neighbors
                    case Dist < 2 of
                        true ->
                            Neighbors = lists:nth(U + 1, AdjList), % AdjList is 0-indexed, lists:nth is 1-indexed
                            {UpdatedQ, UpdatedNodesToKeep} = lists:foldl(
                                fun(V, {AccQ, AccNodesToKeep}) ->
                                    case sets:is_element(V, NewVisited) of
                                        true ->
                                            % Neighbor V already visited, skip
                                            {AccQ, AccNodesToKeep};
                                        false ->
                                            % Add neighbor V to queue and nodes_to_keep
                                            {queue:in({V, Dist + 1}, AccQ), sets:add_element(V, AccNodesToKeep)}
                                    end
                                end,
                                {RestQ, NewNodesToKeep},
                                Neighbors
                            ),
                            bfs(UpdatedQ, AdjList, NewVisited, UpdatedNodesToKeep);
                        false ->
                            % Distance is 2 or more, stop exploring from this node
                            bfs(RestQ, AdjList, NewVisited, NewNodesToKeep)
                    end
            end;
        empty ->
            % Queue is empty, BFS finished
            NodesToKeep
    end.

count_edges(I, MaxI, AdjList, FinalNodesToKeep) ->
    if I > MaxI ->
        % Base case: all nodes checked
        0;
    true ->
        case sets:is_element(I, FinalNodesToKeep) of
            true ->
                % If node I is kept, count its edges to other kept neighbors
                Neighbors = lists:nth(I + 1, AdjList), % AdjList is 0-indexed, lists:nth is 1-indexed
                EdgesFromI = lists:foldl(
                    fun(V, Acc) ->
                        case sets:is_element(V, FinalNodesToKeep) of
                            true -> Acc + 1; % Neighbor V is also kept, count this edge
                            false -> Acc
                        end
                    end,
                    0,
                    Neighbors
                ),
                EdgesFromI + count_edges(I + 1, MaxI, AdjList, FinalNodesToKeep);
            false ->
                % Node I is not kept, skip
                count_edges(I + 1, MaxI, AdjList, FinalNodesToKeep)
        end
    end.