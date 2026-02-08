-module(solution).
-export([countRestrictedPaths/3]).

-define(MOD, 1_000_000_007).
-define(INF, 1 bsl 60). % A sufficiently large number for infinity

countRestrictedPaths(N, Edges, _) ->
    Graph = build_graph(Edges),
    Distances = dijkstra(N, Graph),
    calculate_restricted_paths(N, Graph, Distances).

build_graph(Edges) ->
    lists:foldl(
        fun([U, V, W], AccGraph) ->
            AccGraph1 = maps:update_with(U, fun(List) -> [{W, V} | List] end, [{W, V}], AccGraph),
            maps:update_with(V, fun(List) -> [{W, U} | List] end, [{W, U}], AccGraph1)
        end,
        maps:new(),
        Edges
    ).

dijkstra(N, Graph) ->
    Dist = maps:put(N, 0, maps:new()),
    PQ = gb_trees:insert({0, N}, gb_trees:empty()),
    dijkstra_loop(PQ, Dist, Graph).

dijkstra_loop(PQ, Dist, Graph) ->
    case gb_trees:is_empty(PQ) of
        true -> Dist;
        false ->
            {{D, U}, PQ1} = gb_trees:take_any_delete(PQ),
            case maps:get(U, Dist, ?INF) of
                D -> % Only process if this is the shortest path found so far
                    Neighbors = maps:get(U, Graph, []),
                    {NewPQ, NewDist} = lists:foldl(
                        fun({W, V}, {AccPQ, AccDist}) ->
                            CurrentDistV = maps:get(V, AccDist, ?INF),
                            If D + W < CurrentDistV ->
                                NewAccDist = maps:put(V, D + W, AccDist),
                                NewAccPQ = gb_trees:insert({D + W, V}, AccPQ),
                                {NewAccPQ, NewAccDist};
                            Else -> {AccPQ, AccDist}
                        end, {PQ1, Dist}, Neighbors),
                    dijkstra_loop(NewPQ, NewDist, Graph);
                _ -> dijkstra_loop(PQ1, Dist, Graph) % Already found a shorter path to U
            end
    end.

calculate_restricted_paths(N, Graph, Distances) ->
    Counts = maps:put(N, 1, maps:new()),

    Nodes = lists:seq(1, N),

    % Sort nodes in increasing order of their shortest distance to N
    SortedNodes = lists:sort(
        fun(A, B) ->
            maps:get(A, Distances, ?INF) < maps:get(B, Distances, ?INF)
        end,
        Nodes
    ),

    % Iterate through sorted nodes to calculate restricted paths using DP
    FinalCounts = lists:foldl(
        fun(U, AccCounts) ->
            case U of
                N -> AccCounts; % Base case, already handled
                _ ->
                    NewCountU = lists:foldl(
                        fun({_W, V}, Sum) ->
                            DistU = maps:get(U, Distances, ?INF),
                            DistV = maps:get(V, Distances, ?INF),
                            If DistU > DistV ->
                                (Sum + maps:get(V, AccCounts, 0)) rem ?MOD;
                            Else -> Sum
                        end,
                        0, % Start sum from 0 for current node U
                        maps:get(U, Graph, []) % Get neighbors of U
                    ),
                    maps:put(U, NewCountU, AccCounts)
            end
        end,
        Counts,
        SortedNodes
    ),
    maps:get(1, FinalCounts, 0). % Result for node 1