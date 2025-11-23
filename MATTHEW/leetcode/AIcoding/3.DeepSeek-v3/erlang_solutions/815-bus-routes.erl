-module(bus_routes).
-export([num_buses_to_destination/3]).

num_buses_to_destination(Routes, S, T) ->
    case S =:= T of
        true -> 0;
        false ->
            StopToBuses = build_stop_to_buses(Routes),
            case maps:is_key(S, StopToBuses) andalso maps:is_key(T, StopToBuses) of
                false -> -1;
                true -> bfs(Routes, StopToBuses, S, T)
            end
    end.

build_stop_to_buses(Routes) ->
    lists:foldl(fun(Bus, Acc) ->
        lists:foldl(fun(Stop, AccIn) ->
            maps:update_with(Stop, fun(Buses) -> [Bus | Buses] end, [Bus], AccIn)
        end, Acc, lists:nth(Bus + 1, Routes))
    end, maps:new(), lists:seq(0, length(Routes) - 1)).

bfs(Routes, StopToBuses, S, T) ->
    Queue = queue:from_list([{S, 0}]),
    VisitedStops = sets:from_list([S]),
    VisitedBuses = sets:new(),
    bfs_loop(Routes, StopToBuses, Queue, VisitedStops, VisitedBuses, T).

bfs_loop(Routes, StopToBuses, Queue, VisitedStops, VisitedBuses, T) ->
    case queue:out(Queue) of
        {empty, _} -> -1;
        {{value, {CurrentStop, BusesTaken}}, NewQueue} ->
            case CurrentStop =:= T of
                true -> BusesTaken;
                false ->
                    Buses = maps:get(CurrentStop, StopToBuses),
                    {UpdatedQueue, UpdatedVisitedStops, UpdatedVisitedBuses} =
                        lists:foldl(fun(Bus, {Q, VS, VB}) ->
                            case sets:is_element(Bus, VB) of
                                true -> {Q, VS, VB};
                                false ->
                                    NewVB = sets:add_element(Bus, VB),
                                    lists:foldl(fun(NextStop, {QAcc, VSAcc, VBAcc}) ->
                                        case sets:is_element(NextStop, VSAcc) of
                                            true -> {QAcc, VSAcc, VBAcc};
                                            false ->
                                                NewVS = sets:add_element(NextStop, VSAcc),
                                                NewQ = queue:in({NextStop, BusesTaken + 1}, QAcc),
                                                {NewQ, NewVS, VBAcc}
                                        end
                                    end, {Q, VS, NewVB}, lists:nth(Bus + 1, Routes))
                            end
                        end, {NewQueue, VisitedStops, VisitedBuses}, Buses),
                    bfs_loop(Routes, StopToBuses, UpdatedQueue, UpdatedVisitedStops, UpdatedVisitedBuses, T)
            end
    end.