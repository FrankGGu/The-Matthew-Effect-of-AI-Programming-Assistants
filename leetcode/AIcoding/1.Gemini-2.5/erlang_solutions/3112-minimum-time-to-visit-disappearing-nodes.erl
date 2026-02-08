-module(solution).
-export([minimum_time/3]).

-define(INF, 1_000_000_000_007). % A sufficiently large number for infinity

minimum_time(N, Edges, DisappearingTimeList) ->
    DisappearingTimeArray = array:from_list(DisappearingTimeList),
    Graph = build_graph(N, Edges),

    Distances = array:new([{size, N}, {default, ?INF}]),
    Distances1 = array:set(0, 0, Distances), % Distance to start node (0) is 0

    PQ = gb_trees:insert({0, 0}, true, gb_trees:empty()), % Priority queue: {Time, Node}

    FinalDistances = dijkstra_loop(PQ, Graph, DisappearingTimeArray, Distances1),

    array:foldl(fun(D, Acc) ->
                        Acc ++ [case D of ?INF -> -1; _ -> D end]
                end, [], FinalDistances).

build_graph(N, Edges) ->
    Graph = array:new([{size, N}, {default, []}]),
    lists:foldl(fun([U, V, W], AccGraph) ->
                        AccGraph1 = array:set(U, [{W, V} | array:get(U, AccGraph)], AccGraph),
                        array:set(V, [{W, U} | array:get(V, AccGraph1)], AccGraph1)
                end, Graph, Edges).

dijkstra_loop(PQ, Graph, DisappearingTimeArray, Distances) ->
    case gb_trees:take_min(PQ) of
        none ->
            Distances;
        {{CurrentTime, CurrentNode}, _, NewPQ} ->
            CurrentDist = array:get(CurrentNode, Distances),
            if CurrentTime > CurrentDist ->
                dijkstra_loop(NewPQ, Graph, DisappearingTimeArray, Distances);
            true ->
                DisappearTime = array:get(CurrentNode, DisappearingTimeArray),
                if CurrentTime >= DisappearTime ->
                    dijkstra_loop(NewPQ, Graph, DisappearingTimeArray, Distances);
                true ->
                    Neighbors = array:get(CurrentNode, Graph),
                    {UpdatedPQ, UpdatedDistances} = lists:foldl(
                        fun({Weight, NextNode}, {AccPQ, AccDistances}) ->
                            NewTime = CurrentTime + Weight,
                            NextNodeDist = array:get(NextNode, AccDistances),
                            if NewTime < NextNodeDist ->
                                AccDistances1 = array:set(NextNode, NewTime, AccDistances),
                                AccPQ1 = gb_trees:insert({NewTime, NextNode}, true, AccPQ),
                                {AccPQ1, AccDistances1};
                            true ->
                                {AccPQ, AccDistances}
                            end
                        end, {NewPQ, Distances}, Neighbors),
                    dijkstra_loop(UpdatedPQ, Graph, DisappearingTimeArray, UpdatedDistances)
                end
            end
    end.