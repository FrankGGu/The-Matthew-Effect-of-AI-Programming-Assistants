-module(solution).
-export([num_buses_to_destination/3]).

num_buses_to_destination(BusRoutes, Start, Target) ->
    if
        Start =:= Target -> 0;
        BusRoutes =:= [] -> -1;
        true ->
            Buses = lists:map(fun(Bus) -> {Bus, lists:map(fun(Stop) -> {Stop, Bus} end, Bus)} end, BusRoutes),
            Graph = build_graph(Buses),
            bfs(Graph, Start, Target)
    end.

build_graph(BusRoutes) ->
    lists:foldl(fun({Bus, Stops}, Acc) ->
        lists:foldl(fun(Stop, Acc1) ->
            case maps:get(Stop, Acc1, []) of
                [] -> maps:put(Stop, [Bus], Acc1);
                Buses -> maps:put(Stop, [Bus | Buses], Acc1)
            end
        end, Acc, Stops)
    end, #{}, BusRoutes).

bfs(Graph, Start, Target) ->
    case maps:get(Start, Graph, []) of
        [] -> -1;
        Buses ->
            Queue = [{Start, 0}],
            Visited = maps:put(Start, true, #{}),
            bfs_loop(Queue, Visited, Target)
    end.

bfs_loop([], _, _) -> -1;
bfs_loop([{Stop, Count} | Rest], Visited, Target) ->
    if
        Stop =:= Target -> Count;
        true ->
            case maps:get(Stop, Graph, []) of
                [] -> bfs_loop(Rest, Visited, Target);
                Buses ->
                    NewVisited = lists:foldl(fun(Bus, Acc) ->
                        case maps:get(Bus, Acc, false) of
                            false -> maps:put(Bus, true, Acc);
                            true -> Acc
                        end
                    end, Visited, Buses),
                    NewQueue = lists:foldl(fun(Bus, Acc) ->
                        lists:foldl(fun(NextStop, Acc1) ->
                            [{NextStop, Count + 1} | Acc1]
                        end, Acc, maps:get(Bus, Graph, []))
                    end, Rest, Buses),
                    bfs_loop(NewQueue, NewVisited, Target)
            end
    end.