-module(solution).
-export([electric_car_path/4]).

electric_car_path(Location, Charge, Cost, Target) ->
    {ok, MaxCharge} = maps:find(max_charge, Charge),
    {ok, Start} = maps:find(start, Location),
    {ok, End} = maps:find(end, Location),
    {ok, ChargeTime} = maps:find(charge_time, Charge),
    {ok, DischargeTime} = maps:find(discharge_time, Charge),
    {ok, Stations} = maps:find(stations, Location),
    {ok, Edges} = maps:find(edges, Location),

    Graph = build_graph(Edges),
    StationsSet = sets:from_list(Stations),
    PriorityQueue = [{0, Start, MaxCharge}],
    Visited = #{ {Start, MaxCharge} => 0 },
    electric_car_path_loop(PriorityQueue, Visited, Graph, StationsSet, ChargeTime, DischargeTime, MaxCharge, End, Target).

build_graph(Edges) ->
    lists:foldl(fun({From, To, Distance}, Acc) ->
        maps:update_with(From, fun(List) -> [{To, Distance} | List] end, [{To, Distance}], Acc)
    end, #{}, Edges).

electric_car_path_loop([], _, _, _, _, _, _, _, _) ->
    -1;
electric_car_path_loop([{CurrentCost, CurrentPos, CurrentCharge} | Rest], Visited, Graph, StationsSet, ChargeTime, DischargeTime, MaxCharge, End, Target) ->
    case CurrentPos == End of
        true ->
            CurrentCost;
        false ->
            Neighbors = maps:get(CurrentPos, Graph, []),
            {NewQueue, NewVisited} = process_neighbors(Neighbors, CurrentCost, CurrentPos, CurrentCharge, Visited, StationsSet, ChargeTime, DischargeTime, MaxCharge, Target),
            electric_car_path_loop(merge_queues(Rest, NewQueue), NewVisited, Graph, StationsSet, ChargeTime, DischargeTime, MaxCharge, End, Target)
    end.

process_neighbors([], _, _, _, Visited, _, _, _, _, _) ->
    {[], Visited};
process_neighbors([{NextPos, Distance} | Rest], CurrentCost, CurrentPos, CurrentCharge, Visited, StationsSet, ChargeTime, DischargeTime, MaxCharge, Target) ->
    case Distance > CurrentCharge of
        true ->
            process_neighbors(Rest, CurrentCost, CurrentPos, CurrentCharge, Visited, StationsSet, ChargeTime, DischargeTime, MaxCharge, Target);
        false ->
            NewCharge = CurrentCharge - Distance,
            NewCost = CurrentCost + Distance * Target,
            Key = {NextPos, NewCharge},
            case maps:is_key(Key, Visited) of
                true ->
                    case maps:get(Key, Visited) =< NewCost of
                        true ->
                            process_neighbors(Rest, CurrentCost, CurrentPos, CurrentCharge, Visited, StationsSet, ChargeTime, DischargeTime, MaxCharge, Target);
                        false ->
                            NewVisited = maps:put(Key, NewCost, Visited),
                            NewQueueItem = {NewCost, NextPos, NewCharge},
                            {RestQueue, RestVisited} = process_neighbors(Rest, CurrentCost, CurrentPos, CurrentCharge, NewVisited, StationsSet, ChargeTime, DischargeTime, MaxCharge, Target),
                            {[NewQueueItem | RestQueue], RestVisited}
                    end;
                false ->
                    NewVisited = maps:put(Key, NewCost, Visited),
                    NewQueueItem = {NewCost, NextPos, NewCharge},
                    {RestQueue, RestVisited} = process_neighbors(Rest, CurrentCost, CurrentPos, CurrentCharge, NewVisited, StationsSet, ChargeTime, DischargeTime, MaxCharge, Target),
                    {[NewQueueItem | RestQueue], RestVisited}
            end
    end.

merge_queues(Queue1, Queue2) ->
    lists:sort(fun({Cost1, _, _}, {Cost2, _, _}) -> Cost1 =< Cost2 end, Queue1 ++ Queue2).