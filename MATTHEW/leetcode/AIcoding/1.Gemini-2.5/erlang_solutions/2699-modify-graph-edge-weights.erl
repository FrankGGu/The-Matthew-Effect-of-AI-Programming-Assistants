-module(solution).
-export([modifyGraphEdgeWeights/5]).

-define(INF, 1_000_000_000_000). % A sufficiently large number for infinity

pqueue_new() ->
    gb_trees:empty().

pqueue_in(Element, PQ) ->
    % Element is {Priority, Value}. For Dijkstra, Priority is distance, Value is node.
    % gb_trees:insert/3 uses {Key, Value}. We use {Priority, Value} as Key to handle
    % potential duplicate priorities by keeping the first encountered.
    % This is generally acceptable for Dijkstra's algorithm.
    gb_trees:insert(Element, Element, PQ).

pqueue_out(PQ) ->
    case gb_trees:is_empty(PQ) of
        true ->
            {empty, PQ};
        false ->
            % gb_trees:smallest/1 returns {Key, Value}
            {{Priority, Node}, _Value} = gb_trees:smallest(PQ),
            {Node, gb_trees:delete({Priority, Node}, PQ)}
    end.

dijkstra_map(Graph, Source, Destination) ->
    Dist = #{Source => 0}, % Distance map: Node -> Distance
    PQ = pqueue_new(),    % Priority queue: {Distance, Node}
    PQ1 = pqueue_in({0, Source}, PQ),

    dijkstra_map_loop(PQ1, Dist, Graph, Destination).

dijkstra_map_loop(PQ, Dist, Graph, Destination) ->
    case pqueue_out(PQ) of
        {empty, _PQ2} ->
            maps:get(Destination, Dist, ?INF); % Destination not reached
        {{D, U}, PQ2} ->
            CurrentDistU = maps:get(U, Dist, ?INF),
            case D > CurrentDistU of
                true -> % Already found a shorter path
                    dijkstra_map_loop(PQ2, Dist, Graph, Destination);
                false ->
                    case U == Destination of
                        true -> D; % Destination reached
                        false ->
                            Neighbors = maps:get(U, Graph, []),
                            {NewDistMap, NewPQ} = lists:foldl(
                                fun({Weight, V, _EdgeIdx}, {CurrentDistMap, CurrentPQ}) ->
                                    NewD = D + Weight,
                                    CurrentDistV = maps:get(V, CurrentDistMap, ?INF),
                                    case NewD < CurrentDistV of
                                        true ->
                                            CurrentDistMap1 = maps:put(V, NewD, CurrentDistMap),
                                            CurrentPQ1 = pqueue_in({NewD, V}, CurrentPQ),
                                            {CurrentDistMap1, CurrentPQ1};
                                        false ->
                                            {CurrentDistMap, CurrentPQ}
                                    end
                                end,
                                {Dist, PQ2},
                                Neighbors
                            ),
                            dijkstra_map_loop(NewPQ, NewDistMap, Graph, Destination)
                    end
            end
    end.

modifyGraphEdgeWeights(_N, Edges, Source, Destination, Target) ->
    % Step 1: Build initial graph (all -1 edges are 1)
    % Also collect indices of original -1 edges and keep a copy of original edges.

    {InitialAdjMap, UnknownEdgeIndices, OriginalEdgesList} = lists:foldl(
        fun([U, V, W], {AccAdj, AccUnknownIndices, AccOriginalEdges}) ->
            Idx = length(AccOriginalEdges), % Current index for the edge (0-indexed)

            AdjU = maps:get(U, AccAdj, []),
            AdjV = maps:get(V, AccAdj, []),

            case W of
                -1 ->
                    AccUnknownIndices1 = [Idx | AccUnknownIndices],
                    AccAdj1 = maps:put(U, [{1, V, Idx} | AdjU], AccAdj),
                    AccAdj2 = maps:put(V, [{1, U, Idx} | AdjV], AccAdj1),
                    {AccAdj2, AccUnknownIndices1, AccOriginalEdges ++ [[U, V, W]]};
                _ ->
                    AccAdj1 = maps:put(U, [{W, V, Idx} | AdjU], AccAdj),
                    AccAdj2 = maps:put(V, [{W, U, Idx} | AdjV], AccAdj1),
                    {AccAdj2, AccUnknownIndices, AccOriginalEdges ++ [[U, V, W]]}
            end
        end,
        {maps:new(), [], []},
        Edges
    ),

    % Reverse UnknownEdgeIndices to process them in their original order
    FinalUnknownEdgeIndices = lists:reverse(UnknownEdgeIndices),

    % Step 2: First Dijkstra pass (all -1 edges are 1)
    MinPathDist = dijkstra_map(InitialAdjMap, Source, Destination),

    case MinPathDist of
        ?INF -> % Destination not reachable even with min weights
            [];
        _ when MinPathDist < Target ->
            % Case 1: Minimum possible path is shorter than target.
            % We need to increase the path length by `Target - MinPathDist`.
            % Strategy: Set all unknown edges to 1. Then, for the first unknown edge encountered,
            % add the `NeededIncrease` to its weight. All subsequent unknown edges remain 1.

            NeededIncrease = Target - MinPathDist,

            {FinalResultEdgesModified, _BudgetSpent} = lists:foldl(
                fun(Idx, {AccResEdges, AccBudget}) ->
                    [U, V, _W] = lists:nth(Idx + 1, OriginalEdgesList), % lists are 1-indexed
                    case AccBudget > 0 of
                        true ->
                            % This is the first unknown edge to absorb the budget
                            NewWeight = 1 + AccBudget,
                            AccResEdges1 = lists:replace_nth(Idx + 1, [U, V, NewWeight], AccResEdges),
                            {AccResEdges1, 0}; % Budget spent
                        false ->
                            % Budget already spent, set remaining unknown edges to 1
                            AccResEdges1 = lists:replace_nth(Idx + 1, [U, V, 1], AccResEdges),
                            {AccResEdges1, 0}
                    end
                end,
                {OriginalEdgesList, NeededIncrease}, % Start with original edges, budget
                FinalUnknownEdgeIndices
            ),

            % Final check: Run Dijkstra with the modified edges
            FinalAdj = build_adj_from_edges_map(FinalResultEdgesModified),
            FinalDist = dijkstra_map(FinalAdj, Source, Destination),

            case FinalDist == Target of
                true -> FinalResultEdgesModified;
                false -> [] % This case means the greedy assignment failed (another path became shorter than target)
            end;

        _ when MinPathDist == Target ->
            % Case 2: Minimum possible path is exactly the target.
            % Set all -1 edges to 1 and return.
            ResultEdgesFinal = lists:foldl(
                fun(Idx, AccResEdges) ->
                    [U, V, _W] = lists:nth(Idx + 1, AccResEdges),
                    lists:replace_nth(Idx + 1, [U, V, 1], AccResEdges)
                end,
                OriginalEdgesList,
                FinalUnknownEdgeIndices
            ),
            ResultEdgesFinal;
        _ when MinPathDist > Target ->
            % Case 3: Minimum possible path is already greater than target.
            % Impossible to achieve target, even with minimum weights (1) for -1 edges.
            []
    end.

build_adj_from_edges_map(EdgesList) ->
    lists:foldl(
        fun([U, V, W], AccAdj) ->
            AdjU = maps:get(U, AccAdj, []),
            AdjV = maps:get(V, AccAdj, []),
            AccAdj1 = maps:put(U, [{W, V, 0} | AdjU], AccAdj), % EdgeIdx not used in Dijkstra, can be 0
            maps:put(V, [{W, U, 0} | AdjV], AccAdj1)
        end,
        maps:new(),
        EdgesList
    ).