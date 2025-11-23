-module(solution).
-export([minimum_weighted_subgraph/4]).

-define(INF, 1000000000000000000). %% A sufficiently large number to represent infinity

minimum_weighted_subgraph(N, Edges, Src1, Src2, Dest) ->
    Adj = array:new([{size, N}, {default, []}]),
    RevAdj = array:new([{size, N}, {default, []}]),
    {FinalAdj, FinalRevAdj} = lists:foldl(
        fun([U, V, W], {CurrentAdj, CurrentRevAdj}) ->
            NewAdj = array:set(U, [{V, W} | array:get(U, CurrentAdj)], CurrentAdj),
            NewRevAdj = array:set(V, [{U, W} | array:get(V, CurrentRevAdj)], CurrentRevAdj),
            {NewAdj, NewRevAdj}
        end,
        {Adj, RevAdj},
        Edges
    ),

    Dist1 = dijkstra(N, FinalAdj, Src1),
    Dist2 = dijkstra(N, FinalAdj, Src2),
    Dist3 = dijkstra(N, FinalRevAdj, Dest),

    MinTotal = lists:foldl(
        fun(M, CurrentMin) ->
            D1 = array:get(M, Dist1),
            D2 = array:get(M, Dist2),
            D3 = array:get(M, Dist3),

            if
                D1 == ?INF orelse D2 == ?INF orelse D3 == ?INF ->
                    CurrentMin;
                true ->
                    min(CurrentMin, D1 + D2 + D3)
            end
        end,
        ?INF,
        lists:seq(0, N - 1)
    ),

    if
        MinTotal == ?INF -> -1;
        true -> MinTotal
    end.

dijkstra(N, Adj, StartNode) ->
    Distances = array:new([{size, N}, {default, ?INF}]),
    Distances_init = array:set(StartNode, 0, Distances),

    PQ_init = gb_trees:insert({0, StartNode}, true, gb_trees:empty()),

    dijkstra_loop(PQ_init, Distances_init, Adj).

dijkstra_loop(PQ, Distances, Adj) ->
    if
        gb_trees:is_empty(PQ) ->
            Distances;
        true ->
            {{D, U}, _, PQ_rest} = gb_trees:take_smallest(PQ),

            CurrentDistU = array:get(U, Distances),

            if
                D > CurrentDistU ->
                    dijkstra_loop(PQ_rest, Distances, Adj);
                true ->
                    Neighbors = array:get(U, Adj),
                    {NewPQ, NewDistances} = lists:foldl(
                        fun({V, W}, {AccPQ, AccDistances}) ->
                            IfNewDist = CurrentDistU + W,
                            CurrentDistV = array:get(V, AccDistances),

                            if
                                IfNewDist < CurrentDistV ->
                                    UpdatedDistances = array:set(V, IfNewDist, AccDistances),
                                    UpdatedPQ = gb_trees:insert({IfNewDist, V}, true, AccPQ),
                                    {UpdatedPQ, UpdatedDistances};
                                true ->
                                    {AccPQ, AccDistances}
                            end
                        end,
                        {PQ_rest, Distances},
                        Neighbors
                    ),
                    dijkstra_loop(NewPQ, NewDistances, Adj)
            end
    end.