-record(customer, {id, check_in_station, check_in_time}).
-record(trip, {start_station, end_station, total_time, count}).

start() ->
    spawn(fun() -> loop(#{} , #{}) end).

loop(Customers, Trips) ->
    receive
        {check_in, Pid, Id, StationName, T} ->
            NewCustomers = maps:put(Id, #customer{id=Id, check_in_station=StationName, check_in_time=T}, Customers),
            Pid ! ok,
            loop(NewCustomers, Trips);
        {check_out, Pid, Id, StationName, T} ->
            #customer{check_in_station=StartStation, check_in_time=StartTime} = maps:get(Id, Customers),
            NewCustomers = maps:remove(Id, Customers),
            Key = {StartStation, StationName},
            case maps:find(Key, Trips) of
                {ok, #trip{total_time=Total, count=Count}} ->
                    NewTrips = maps:put(Key, #trip{start_station=StartStation, end_station=StationName, total_time=Total + (T - StartTime), count=Count + 1}, Trips);
                error ->
                    NewTrips = maps:put(Key, #trip{start_station=StartStation, end_station=StationName, total_time=T - StartTime, count=1}, Trips)
            end,
            Pid ! ok,
            loop(NewCustomers, NewTrips);
        {get_average_time, Pid, StartStation, EndStation} ->
            Key = {StartStation, EndStation},
            #trip{total_time=Total, count=Count} = maps:get(Key, Trips),
            Pid ! {ok, Total / Count},
            loop(Customers, Trips);
        _ ->
            loop(Customers, Trips)
    end.

check_in(Pid, Id, StationName, T) ->
    Pid ! {check_in, self(), Id, StationName, T},
    receive
        ok -> ok
    end.

check_out(Pid, Id, StationName, T) ->
    Pid ! {check_out, self(), Id, StationName, T},
    receive
        ok -> ok
    end.

get_average_time(Pid, StartStation, EndStation) ->
    Pid ! {get_average_time, self(), StartStation, EndStation},
    receive
        {ok, Avg} -> Avg
    end.