-module(underground_system).
-export([new/0, check_in/3, check_out/2, get_average_time/2]).

-record(passenger, {id, station, time}).
-record(ride, {total_time, count}).

new() ->
    ets:new(station_data, [set, public]),
    ets:new(passenger_data, [set, public]).

check_in(Id, Station, Time) ->
    Passenger = #passenger{id = Id, station = Station, time = Time},
    ets:insert(passenger_data, {Id, Passenger}).

check_out(Id, Station, Time) ->
    case ets:lookup(passenger_data, Id) of
        [{Id, #passenger{station=StartStation, time=StartTime}}] ->
            Duration = Time - StartTime,
            Key = {StartStation, Station},
            case ets:lookup(station_data, Key) of
                [] ->
                    ets:insert(station_data, {Key, #ride{total_time=Duration, count=1}});
                [{Key, #ride{total_time=TotalTime, count=Count}}] ->
                    ets:insert(station_data, {Key, #ride{total_time=TotalTime + Duration, count=Count + 1}})
            end,
            ets:delete(passenger_data, Id);
        _ ->
            ok
    end.

get_average_time(StartStation, EndStation) ->
    Key = {StartStation, EndStation},
    case ets:lookup(station_data, Key) of
        [{Key, #ride{total_time=TotalTime, count=Count}}] ->
            TotalTime / Count;
        _ ->
            0.0
    end.