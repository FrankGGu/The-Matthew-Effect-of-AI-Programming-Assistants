-module(solution).
-export([latest_time_to_catch_bus/3]).

latest_time_to_catch_bus(BusTimes, Passengers, Capacity) ->
    SortedBusTimes = lists:sort(BusTimes),
    SortedPassengers = lists:sort(Passengers),
    {LastBusTime, _} = lists:foldl(fun(Time, {Last, Count}) ->
        {Time, min(Count + Capacity, Count + 1)}
    end, {0, 0}, SortedBusTimes),
    PassengersCaught = lists:takewhile(fun(P) -> P < LastBusTime end, SortedPassengers),
    CountCaught = length(PassengersCaught),
    if CountCaught < Capacity -> LastBusTime;
       CountCaught =:= Capacity -> 
           MaxPassenger = lists:max(PassengersCaught),
           MaxPassenger - 1;
       true -> 
           LastBusTime
    end.