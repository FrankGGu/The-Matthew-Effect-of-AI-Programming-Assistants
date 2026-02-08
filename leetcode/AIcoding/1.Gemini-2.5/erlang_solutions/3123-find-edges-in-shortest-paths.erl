-module(solution).
-export([find_shortest_paths_edges/2]).

-define(INF, 1000000000000000000).

dijkstra(N, AdjList, StartNode) ->
    % Initialize distances array: all to infinity, start node to 0.
    Distances = array:new(N, {default, ?INF}),
    Distances1 = array:set(StartNode, 0, Distances),

    % Priority queue: gb_trees stores {Distance, Node} tuples, ordered by Distance.
    PQ = gb_trees:insert({0, StartNode}, gb_trees:empty()),

    dijkstra_loop(Distances1, PQ, AdjList).

dijkstra_loop(Distances, PQ, AdjList) ->
    case gb_trees:is_empty(PQ) of
        true ->
            Distances;
        false ->
            {{CurrentDist, U}, PQ1} = gb_trees:take_smallest(PQ),

            % If we've already found a shorter path to U and finalized it, skip this entry.
            % This can happen if U was added to the priority queue multiple times with different distances,
            % and a shorter path was processed earlier.
            if CurrentDist > array:get(U, Distances) ->
                dijkstra_loop(Distances, PQ1, AdjList);
            true ->
                Neighbors = array:get(U, AdjList),
                {NewDistances, NewPQ} = lists:foldl(
                    fun({V, Weight}, {AccDistances, AccPQ}) ->
                        NewDist = CurrentDist + Weight,
                        IfV = array:get(V, AccDistances),
                        if NewDist < IfV ->
                            % Found a shorter path to V, update distance and add to PQ.
                            {array:set(V, NewDist, AccDistances), gb_trees:insert({NewDist, V}, AccPQ)};
                        true ->
                            % No shorter path found, keep current state.
                            {AccDistances, AccPQ}
                        end
                    end,
                    {Distances, PQ1},
                    Neighbors
                ),
                dijkstra_loop(NewDistances, NewPQ, AdjList)
            end
    end.

find_shortest_paths_edges(N, Edges) ->
    % Build adjacency list for the undirected graph.
    % Each edge [U, V, W] means there's an edge U-V with weight W.
    AdjList = array:new(N, {default, []}),
    AdjList1 = lists:foldl(
        fun([U, V, W], AccAdjList) ->
            % Add U -> V
            AccAdjList1 = array:set(U, [{V, W} | array:get(U, AccAdjList)], AccAdjList),
            % Add V -> U (for undirected graph)
            array:set(V, [{U, W} | array:get(V, AccAdjList1)], AccAdjList1)
        end,
        AdjList,
        Edges
    ),

    % Run Dijkstra from the source node (0) to get shortest distances to all nodes.
    DistS = dijkstra(N, AdjList1, 0),

    % Run Dijkstra from the destination node (N-1) to get shortest distances
    % from all nodes to the destination.
    DistT = dijkstra(N, AdjList1, N-1),

    % Get the shortest path length from 0 to N-1.
    ShortestPathLen = array:get(N-1, DistS),

    % Iterate through all original edges to find those on a shortest path.
    lists:foldl(
        fun([U, V, W], AccResult) ->
            DistSU = array:get(U, DistS), % Shortest distance from 0 to U
            DistSV = array:get(V, DistS), % Shortest distance from 0 to V
            DistTU = array:get(U, DistT), % Shortest distance from U to N-1
            DistTV = array:get(V, DistT), % Shortest distance from V to N-1

            % An edge (U, V) with weight W is part of a shortest path from 0 to N-1
            % if (shortest path from 0 to U) + W + (shortest path from V to N-1)
            % equals the overall shortest path length from 0 to N-1.
            % OR
            % (shortest path from 0 to V) + W + (shortest path from U to N-1)
            % equals the overall shortest path length from 0 to N-1.
            IsOnShortestPath =
                (DistSU + W + DistTV == ShortestPathLen) orelse
                (DistSV + W + DistTU == ShortestPathLen),

            if IsOnShortestPath ->
                [[U, V] | AccResult];
            true ->
                AccResult
            end
        end,
        [], % Initial accumulator for the result list
        Edges
    )
    .