-module(solution).
-export([minimum_time/2]).

minimum_time(Time, TotalTrips) ->
    MaxBusTime = lists:max(Time),
    Low = 1,
    High = TotalTrips * MaxBusTime,
    binary_search(Low, High, High, Time, TotalTrips).

binary_search(Low, High, CurrentAns, TimeList, TotalTrips) when Low =< High ->
    Mid = Low + (High - Low) div 2,
    TripsCompleted = lists:sum([Mid div BusTime || BusTime <- TimeList]),
    if
        TripsCompleted >= TotalTrips ->
            binary_search(Low, Mid - 1, Mid, TimeList, TotalTrips);
        true ->
            binary_search(Mid + 1, High, CurrentAns, TimeList, TotalTrips)
    end;
binary_search(_, _, CurrentAns, _, _) ->
    CurrentAns.