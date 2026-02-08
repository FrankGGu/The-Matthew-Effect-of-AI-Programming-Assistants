-module(solution).
-export([count_paths/2]).

-define(INF, 1_000_000_000_000_000_000).
-define(MOD, 1_000_000_007).

count_paths(N, Roads) ->
    Graph = build_graph(N, Roads),
    dijkstra(N, Graph).

build_graph(N, Roads) ->
    lists:foldl(
        fun([U, V, Time], Acc) ->
            Acc1 = dict:update(U, fun(L) -> [{V, Time} | L] end, [{V, Time}], Acc),
            Acc2 = dict:update(V, fun(L) -> [{U, Time} | L] end, [{U, Time}], Acc1),
            Acc2
        end,
        dict:new(),
        Roads
    ).

dijkstra(N, Graph) ->
    Distances = array:from_list(lists:duplicate(N, ?INF)),
    Ways = array:from_list(lists:duplicate(N, 0)),

    Distances_0 = array:set(0, 0, Distances),
    Ways_0 = array:set(0, 1, Ways),

    PQ = gb_trees:insert({0, 0}, true, gb_trees:empty()),

    dijkstra_loop(PQ, Distances_0, Ways_0, Graph, N).

dijkstra_loop(PQ, Distances, Ways, Graph, N) ->
    case gb_trees:is_empty(PQ) of
        true ->
            array:get(N - 1, Ways);
        false ->
            {{Time, U}, _, NewPQ} = gb_trees:take_smallest(PQ),

            CurrentDistanceU = array:get(U, Distances),

            if Time > CurrentDistanceU ->
                dijkstra_loop(NewPQ, Distances, Ways, Graph, N);
            true ->
                case dict:find(U, Graph) of
                    {ok, NeighborsList} ->
                        {NewDistances, NewWays, UpdatedPQ} =
                            lists:foldl(
                                fun({V, Weight}, {AccDist, AccWays, AccPQ}) ->
                                    NewTime = Time + Weight,
                                    CurrentDistanceV = array:get(V, AccDist),

                                    if NewTime < CurrentDistanceV ->
                                        UpdatedAccDist = array:set(V, NewTime, AccDist),
                                        UpdatedAccWays = array:set(V, array:get(U, AccWays), AccWays),
                                        UpdatedAccPQ = gb_trees:insert({NewTime, V}, true, AccPQ),
                                        {UpdatedAccDist, UpdatedAccWays, UpdatedAccPQ};
                                    NewTime == CurrentDistanceV ->
                                        WaysU = array:get(U, AccWays),
                                        CurrentWaysV = array:get(V, AccWays),
                                        NewWaysV = (CurrentWaysV + WaysU) rem ?MOD,
                                        UpdatedAccWays = array:set(V, NewWaysV, AccWays),
                                        {AccDist, UpdatedAccWays, AccPQ};
                                    true ->
                                        {AccDist, AccWays, AccPQ}
                                    end
                                end,
                                {Distances, Ways, NewPQ},
                                NeighborsList
                            ),
                        dijkstra_loop(UpdatedPQ, NewDistances, NewWays, Graph, N);
                    error ->
                        dijkstra_loop(NewPQ, Distances, Ways, Graph, N)
                end
            end
    end.