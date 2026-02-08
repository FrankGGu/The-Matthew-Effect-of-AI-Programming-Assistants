-module(underground_system).
-export([start/1, checkIn/3, checkOut/3, getAverageTime/2]).

-record(station, {name, time}).
-record(journey, {start_station, start_time, end_station, end_time}).

-type station_name() :: string().
-type time() :: integer().
-type id() :: integer().

-type state() :: #{
    passengers => #{id() => station()},
    travel_times => #{
        {station_name(), station_name()} => {integer(), integer()} % {total_time, count}
    }
}.

start() -> #{passengers => #{}, travel_times => #{}}.

checkIn(State, Id, StationName, T) ->
    NewPassengers = maps:put(State#{}, passengers, maps:put(State#passengers, Id, #station{name = StationName, time = T})),
    NewPassengers.

checkOut(State, Id, StationName, T) ->
    #station{name = StartStationName, time = StartTime} = maps:get(Id, State#passengers),
    NewState = maps:put(State#{}, passengers, maps:remove(Id, State#passengers)),

    Key = {StartStationName, StationName},
    {TotalTime, Count} = maps:get(Key, State#travel_times, {0, 0}),
    NewTotalTime = TotalTime + (T - StartTime),
    NewCount = Count + 1,

    NewTravelTimes = maps:put(NewState#{}, travel_times, maps:put(State#travel_times, Key, {NewTotalTime, NewCount})),
    NewTravelTimes.

getAverageTime(State, StartStation, EndStation) ->
    {TotalTime, Count} = maps:get({StartStation, EndStation}, State#travel_times),
    TotalTime / Count.