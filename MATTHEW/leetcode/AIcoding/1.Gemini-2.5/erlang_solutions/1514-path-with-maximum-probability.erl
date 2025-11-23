-module(solution).
-export([maxProbability/4]).

maxProbability(N, Edges, Start, End) ->
    % Build adjacency list: maps: #{Node => [{Neighbor, Probability}]}
    Adj = build_adj(Edges),

    % MaxProbs array: array:array() stores max probability found to each node
    % Initialized to 0.0 for all nodes, 1.0 for the Start node.
    MaxProbs = array:set(Start, 1.0, array:new(N, {default, 0.0})),

    % Priority queue: gb_trees stores {Probability, Node}
    % gb_trees:take_max/1 extracts the node with the highest probability.
    PQ = gb_trees:insert({1.0, Start}, gb_trees:empty()),

    dijkstra(PQ, Adj, MaxProbs, End).

build_adj(Edges) ->
    lists:foldl(
        fun([U, V, Prob], Acc) ->
            % Add edge U -> V
            Acc1 = maps:update_with(U, fun(L) -> [{V, Prob} | L] end, [{V, Prob}], Acc),
            % Add edge V -> U (graph is undirected)
            maps:update_with(V, fun(L) -> [{U, Prob} | L] end, [{U, Prob}], Acc1)
        end,
        maps:new(), % Initial empty map for adjacency list
        Edges
    ).

dijkstra(PQ, Adj, MaxProbs, End) ->
    case gb_trees:is_empty(PQ) of
        true ->
            % If priority queue is empty, no more reachable nodes to process
            array:get(End, MaxProbs);
        false ->
            % Extract node with the highest probability from the priority queue
            {{CurrentProb, CurrentNode}, NewPQ} = gb_trees:take_max(PQ),

            % Optimization: If we've already found a better path to CurrentNode,
            % this entry in the PQ is stale. Skip it.
            StoredProb = array:get(CurrentNode, MaxProbs),
            if CurrentProb < StoredProb ->
                dijkstra(NewPQ, Adj, MaxProbs, End);
            true ->
                % Process neighbors of CurrentNode
                Neighbors = maps:get(CurrentNode, Adj, []), % Get neighbors, default to empty list if no entry
                {UpdatedPQ, UpdatedMaxProbs} = lists:foldl(
                    fun({Neighbor, EdgeProb}, {AccPQ, AccMaxProbs}) ->
                        NewProb = CurrentProb * EdgeProb,
                        StoredNeighborProb = array:get(Neighbor, AccMaxProbs),
                        if NewProb > StoredNeighborProb ->
                            % Found a better path to Neighbor
                            {gb_trees:insert({NewProb, Neighbor}, AccPQ), % Add to PQ
                             array:set(Neighbor, NewProb, AccMaxProbs)}; % Update max probability
                        true ->
                            % No improvement, keep current state
                            {AccPQ, AccMaxProbs}
                        end
                    end,
                    {NewPQ, MaxProbs}, % Initial accumulator for foldl
                    Neighbors
                ),
                dijkstra(UpdatedPQ, Adj, UpdatedMaxProbs, End)
            end
    end.