-spec latest_time_catch_bus(Buses :: [integer()], Passengers :: [integer()], Capacity :: integer()) -> integer().
latest_time_catch_bus(Buses, Passengers, Capacity) ->
    SortedBuses = lists:sort(Buses),
    SortedPassengers = lists:sort(Passengers),
    {LastTime, _} = catch_bus(SortedBuses, SortedPassengers, Capacity, 0, 0),
    LastTime.

catch_bus([Bus | Buses], Passengers, Capacity, LastTime, PassIndex) ->
    PassOnBus = 0,
    {NewPassIndex, NewPassOnBus} = board_passengers(Passengers, Bus, Capacity, PassIndex, PassOnBus),
    case NewPassOnBus < Capacity of
        true ->
            Candidate = find_max_time(Passengers, Bus, NewPassIndex),
            NewLastTime = max(LastTime, Candidate),
            catch_bus(Buses, Passengers, Capacity, NewLastTime, NewPassIndex);
        false ->
            Candidate = lists:nth(NewPassIndex, Passengers) - 1,
            NewLastTime = max(LastTime, Candidate),
            catch_bus(Buses, Passengers, Capacity, NewLastTime, NewPassIndex)
    end;
catch_bus([], _, _, LastTime, _) ->
    {LastTime, 0}.

board_passengers(Passengers, Bus, Capacity, PassIndex, PassOnBus) when PassIndex < length(Passengers) + 1 andalso PassOnBus < Capacity ->
    case lists:nth(PassIndex, Passengers) =< Bus of
        true ->
            board_passengers(Passengers, Bus, Capacity, PassIndex + 1, PassOnBus + 1);
        false ->
            {PassIndex, PassOnBus}
    end;
board_passengers(_, _, _, PassIndex, PassOnBus) ->
    {PassIndex, PassOnBus}.

find_max_time(Passengers, Bus, PassIndex) ->
    case PassIndex == 1 of
        true ->
            Bus;
        false ->
            case lists:nth(PassIndex - 1, Passengers) < Bus of
                true ->
                    lists:nth(PassIndex - 1, Passengers) - 1;
                false ->
                    Bus
            end
    end.