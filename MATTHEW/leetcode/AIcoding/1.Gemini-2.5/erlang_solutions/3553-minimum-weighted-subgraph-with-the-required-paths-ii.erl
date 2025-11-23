-module(solution).
-export([minimum_weighted_subgraph/5]).

-define(INFINITY, 1_000_000_000_000_000).

dijkstra(N, Adj, StartNode) ->
    Distances = array:new(N, {default, ?INFINITY}),
    Distances1 = array:set(StartNode, 0, Distances),

    %% Priority queue stores {Cost, Node}. gb_trees keeps keys sorted.
    PQ = gb_trees:insert({0, StartNode}, true, gb_trees:empty()),

    dijkstra_loop(PQ, Adj, Distances1).

dijkstra_loop(PQ, _Adj, Distances) when gb_trees:is_empty(PQ) ->
    Distances;
dijkstra_loop(PQ, Adj, Distances) ->
    {{Cost, U}, PQ1} = gb_trees:take_smallest(PQ),

    CurrentDistU = array:get(U, Distances),

    %% If we've already found a shorter path to U, skip this entry.
    %% This handles cases where a node is added to the PQ multiple times with different costs.
    if Cost > CurrentDistU ->
        dijkstra_loop(PQ1, Adj, Distances);
    true ->
        %% Get neighbors of U. If U has no outgoing edges, maps:get returns [].
        Neighbors = maps:get(U, Adj, []), 

        {NewPQ, NewDistances} = lists:foldl(
            fun({V, Weight}, {AccPQ, AccDistances}) ->
                NewDist = CurrentDistU + Weight,
                CurrentDistV = array:get(V, AccDistances),
                if NewDist < CurrentDistV ->
                    AccDistances1 = array:set(V, NewDist, AccDistances),
                    AccPQ1 = gb_trees:insert({NewDist, V}, true, AccPQ),
                    {AccPQ1, AccDistances1};
                true ->
                    {AccPQ, AccDistances}
                end
            end,
            {PQ1, Distances},
            Neighbors
        ),
        dijkstra_loop(NewPQ, NewDistances)
    end.

minimum_weighted_subgraph(N, Edges, Source1, Source2, Dest) ->
    %% Build adjacency list for the forward graph.
    Adj = lists:foldl(
        fun([U, V, W], Acc) ->
            maps:update_with(U, fun(List) -> [{V, W} | List] end, [{V, W}], Acc)
        end,
        maps:empty(),
        Edges
    ),

    %% Build adjacency list for the reversed graph (for paths TO Dest).
    RevAdj = lists:foldl(
        fun([U, V, W], Acc) ->
            maps:update_with(V, fun(List) -> [{U, W} | List] end, [{U, W}], Acc)
        end,
        maps:empty(),
        Edges
    ),

    %% Run Dijkstra from Source1 to find shortest paths to all nodes.
    Distances1 = dijkstra(N, Adj, Source1),

    %% Run Dijkstra from Source2 to find shortest paths to all nodes.
    Distances2 = dijkstra(N, Adj, Source2),

    %% Run Dijkstra from Dest on the reversed graph to find shortest paths from all nodes to Dest.
    Distances3_rev = dijkstra(N, RevAdj, Dest),

    %% Iterate through all possible meeting nodes (M) from 0 to N-1.
    %% Calculate D1[M] + D2[M] + D3[M] and find the minimum.
    MinTotalCost = lists:foldl(
        fun(I, AccMin) ->
            D1 = array:get(I, Distances1),
            D2 = array:get(I, Distances2),
            D3 = array:get(I, Distances3_rev),

            %% If any of the paths to/from node I is unreachable, skip this node.
            if D1 == ?INFINITY orelse D2 == ?INFINITY orelse D3 == ?INFINITY ->
                AccMin;
            true ->
                min(AccMin, D1 + D2 + D3)
            end
        end,
        ?INFINITY, %% Initial minimum cost is infinity.
        lists:seq(0, N - 1)
    ),

    %% If MinTotalCost is still infinity, it means no valid subgraph was found.
    if MinTotalCost == ?INFINITY ->
        -1;
    true ->
        MinTotalCost
    end.