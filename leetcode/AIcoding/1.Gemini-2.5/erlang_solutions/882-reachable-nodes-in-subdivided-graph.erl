-module(solution).
-export([reachable_nodes/3]).

reachable_nodes(Edges, M, N) ->
    % Initialize Graph and EdgeInfo
    % Graph: maps:map() where key is node, value is a list of [{Neighbor, Weight}]
    % EdgeInfo: maps:map() where key is {min(U,V), max(U,V)}, value is {OriginalWeight, ReachFromU, ReachFromV}
    % ReachFromU/V store max subdivisions reachable from that end of the edge.
    {InitialGraph, InitialEdgeInfo} = lists:foldl(
        fun([U, V, W], {AccGraph, AccEdgeInfo}) ->
            NewGraph1 = maps:update_with(U, fun(L) -> [{V, W}|L] end, [{V, W}], AccGraph),
            NewGraph2 = maps:update_with(V, fun(L) -> [{U, W}|L] end, [{U, W}], NewGraph1),
            EdgeKey = {min(U, V), max(U, V)},
            NewEdgeInfo = maps:put(EdgeKey, {W, 0, 0}, AccEdgeInfo), % Initialize reach counts to 0
            {NewGraph2, NewEdgeInfo}
        end,
        {maps:new(), maps:new()},
        Edges
    ),

    % Initialize Dijkstra's structures
    % Dist: maps:map() where key is node, value is Max_Moves_Left_Upon_Reaching_Node
    %       Initialize with -1 for unreachable nodes, M for start node 0.
    Dist = maps:put(0, M, maps:new()),
    % PQ: gb_trees (priority queue) storing {-Moves_Left, Node}
    %     We use negative moves for min-heap behavior to extract max moves_left.
    PQ = gb_trees:insert({-M, 0}, 0, gb_trees:empty()),

    % Run Dijkstra's algorithm
    {FinalDist, FinalEdgeInfo} = dijkstra(PQ, Dist, InitialGraph, InitialEdgeInfo),

    % Calculate total reachable nodes
    % 1. Count original nodes reachable
    ReachableOriginalNodes = maps:fold(
        fun(_Node, MovesLeft, Acc) ->
            if MovesLeft >= 0 -> Acc + 1; % Node is reachable if moves left is non-negative
            true -> Acc
            end
        end,
        0,
        FinalDist
    ),

    % 2. Count subdivided nodes reachable
    ReachableSubdividedNodes = maps:fold(
        fun(_EdgeKey, {Weight, ReachU, ReachV}, Acc) ->
            % For each edge, the total number of unique subdivisions reachable is
            % the minimum of its original weight and the sum of reaches from both ends.
            Acc + min(Weight, ReachU + ReachV)
        end,
        0,
        FinalEdgeInfo
    ),

    ReachableOriginalNodes + ReachableSubdividedNodes.

dijkstra(PQ, Dist, Graph, EdgeInfo) ->
    case gb_trees:is_empty(PQ) of
        true ->
            % Priority queue is empty, Dijkstra's finished
            {Dist, EdgeInfo};
        false ->
            % Get the node with the maximum moves_left (smallest negative moves)
            {{NegMoves, U}, _Value, NewPQ} = gb_trees:take_smallest(PQ),
            MovesAtU = -NegMoves, % Actual moves left at node U

            % Optimization: If we've already found a better path to U, skip this entry.
            % This handles duplicate entries in the PQ efficiently.
            case MovesAtU < maps:get(U, Dist, -1) of
                true ->
                    dijkstra(NewPQ, Dist, Graph, EdgeInfo);
                false ->
                    Neighbors = maps:get(U, Graph, []),
                    % Process all neighbors of U
                    {UpdatedDist, UpdatedEdgeInfo, FinalPQ} = lists:foldl(
                        fun({V, _Weight_from_graph}, Acc) ->
                            {CurrentDist, CurrentEdgeInfo, CurrentPQ} = Acc,

                            EdgeKey = {min(U, V), max(U, V)},
                            {OriginalWeight, ReachU, ReachV} = maps:get(EdgeKey, CurrentEdgeInfo),

                            % Calculate how many subdivisions on the edge (U,V) are reachable from U
                            % To reach `k` subdivisions, it costs `k` moves.
                            % So, with `MovesAtU` moves, we can reach `MovesAtU - 1` subdivisions.
                            % This is capped by the `OriginalWeight`.
                            SubdivisionsReachableFromU = max(0, min(OriginalWeight, MovesAtU - 1)),

                            % Update the EdgeInfo map with the maximum reach from U
                            NewEdgeInfo = 
                                if U < V -> maps:put(EdgeKey, {OriginalWeight, max(ReachU, SubdivisionsReachableFromU), ReachV}, CurrentEdgeInfo);
                                else -> maps:put(EdgeKey, {OriginalWeight, ReachU, max(ReachV, SubdivisionsReachableFromU)}, CurrentEdgeInfo)
                                end,

                            % Calculate cost to traverse the entire edge to node V
                            CostToTraverse = OriginalWeight + 1,

                            % If we have enough moves to reach node V
                            if MovesAtU >= CostToTraverse ->
                                RemainingMovesAtV = MovesAtU - CostToTraverse,
                                % If reaching V via U gives more remaining moves than previously known
                                if RemainingMovesAtV > maps:get(V, CurrentDist, -1) ->
                                    % Update Dist for V and add V to PQ
                                    {maps:put(V, RemainingMovesAtV, CurrentDist),
                                     NewEdgeInfo,
                                     gb_trees:insert({-RemainingMovesAtV, V}, V, CurrentPQ)};
                                else ->
                                    % No improvement, keep current state
                                    {CurrentDist, NewEdgeInfo, CurrentPQ}
                                end;
                            else -> % V cannot be reached
                                {CurrentDist, NewEdgeInfo, CurrentPQ}
                            end
                        end,
                        {Dist, NewEdgeInfo, NewPQ}, % Initial accumulator for foldl
                        Neighbors
                    ),
                    % Continue Dijkstra with updated state
                    dijkstra(FinalPQ, UpdatedDist, Graph, UpdatedEdgeInfo)
            end
    end.