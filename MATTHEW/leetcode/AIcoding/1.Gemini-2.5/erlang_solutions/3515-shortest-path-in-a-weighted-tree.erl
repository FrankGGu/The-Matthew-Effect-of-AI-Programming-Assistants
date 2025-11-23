-module(solution).
-export([shortestPath/4]).

shortestPath(N, Edges, StartNode, EndNode) ->
    Adj = build_adj_list(N, Edges),
    Distances = dijkstra(N, Adj, StartNode),
    maps:get(EndNode, Distances, infinity()).

infinity() -> 1000000000000000.

build_adj_list(N, Edges) ->
    lists:foldl(
        fun({U, V, W}, Acc) ->
            NewAcc1 = maps:update_with(U, fun(List) -> [{V, W} | List] end, [{V, W}], Acc),
            maps:update_with(V, fun(List) -> [{U, W} | List] end, [{U, W}], NewAcc1)
        end,
        maps:new(),
        Edges
    ).

dijkstra(N, Adj, StartNode) ->
    InitialDistances = maps:put(StartNode, 0, maps:from_list([{I, infinity()} || I <- lists:seq(1, N)])),
    InitialPQ = gb_trees:insert({0, StartNode}, true, gb_trees:empty()),

    dijkstra_loop(Adj, InitialDistances, InitialPQ).

dijkstra_loop(Adj, Distances, PQ) ->
    case gb_trees:is_empty(PQ) of
        true -> Distances;
        false ->
            {{MinDist, U}, _, NewPQ} = gb_trees:take_smallest(PQ),

            CurrentDistU = maps:get(U, Distances, infinity()),

            if
                MinDist > CurrentDistU ->
                    dijkstra_loop(Adj, Distances, NewPQ);
                true ->
                    Neighbors = maps:get(U, Adj, []),
                    {UpdatedDistances, UpdatedPQ} = lists:foldl(
                        fun({V, Weight}, {AccDistances, AccPQ}) ->
                            NewDistV = MinDist + Weight,
                            CurrentDistV = maps:get(V, AccDistances, infinity()),
                            if
                                NewDistV < CurrentDistV ->
                                    NewAccDistances = maps:put(V, NewDistV, AccDistances),
                                    NewAccPQ = gb_trees:insert({NewDistV, V}, true, AccPQ),
                                    {NewAccDistances, NewAccPQ};
                                true ->
                                    {AccDistances, AccPQ}
                            end
                        end,
                        {Distances, NewPQ},
                        Neighbors
                    ),
                    dijkstra_loop(Adj, UpdatedDistances, UpdatedPQ)
            end
    end.