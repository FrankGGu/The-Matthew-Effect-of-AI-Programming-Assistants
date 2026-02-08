-module(underground_system).
-export([new/0, check_in/4, check_out/4, get_average_time/3]).

-record(state, {
    checked_in = #{}, % Map: CustomerId -> {StationName, CheckInTime}
    trip_averages = #{} % Map: {StartStation, EndStation} -> {TotalTravelTime, Count}
}).

new() ->
    #state{}.

check_in(Id, StationName, T, #state{checked_in = CheckedIn, trip_averages = TripAverages}) ->
    NewCheckedIn = maps:put(Id, {StationName, T}, CheckedIn),
    #state{checked_in = NewCheckedIn, trip_averages = TripAverages}.

check_out(Id, EndStationName, T, #state{checked_in = CheckedIn, trip_averages = TripAverages}) ->
    {StartStationName, StartTime} = maps:get(Id, CheckedIn),
    NewCheckedIn = maps:remove(Id, CheckedIn),

    TravelTime = T - StartTime,

    TripKey = {StartStationName, EndStationName},
    {CurrentTotalTime, CurrentCount} = maps:get(TripKey, TripAverages, {0, 0}),

    NewTotalTime = CurrentTotalTime + TravelTime,
    NewCount = CurrentCount + 1,

    NewTripAverages = maps:put(TripKey, {NewTotalTime, NewCount}, TripAverages),

    #state{checked_in = NewCheckedIn, trip_averages = NewTripAverages}.

get_average_time(StartStation, EndStation, #state{trip_averages = TripAverages}) ->
    TripKey = {StartStation, EndStation},
    {TotalTime, Count} = maps:get(TripKey, TripAverages),
    float(TotalTime) / Count.