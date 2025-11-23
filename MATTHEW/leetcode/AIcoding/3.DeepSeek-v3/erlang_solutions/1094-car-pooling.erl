-spec car_pooling(Trips :: [[integer()]], Capacity :: integer()) -> boolean().
car_pooling(Trips, Capacity) ->
    Events = lists:foldl(fun([Passengers, From, To], Acc) ->
        [{From, Passengers}, {To, -Passengers} | Acc]
    end, [], Trips),
    SortedEvents = lists:keysort(1, Events),
    check_events(SortedEvents, Capacity, 0).

check_events([], _, _) -> true;
check_events([{_, Passengers} | Rest], Capacity, Current) ->
    NewCurrent = Current + Passengers,
    if
        NewCurrent > Capacity -> false;
        true -> check_events(Rest, Capacity, NewCurrent)
    end.