-module(latest_time_to_catch_bus).
-export([latest_time_catch_the_bus/3]).

latest_time_catch_the_bus(Buses, Passengers, Capacity) ->
    SortedBuses = lists:sort(Buses),
    SortedPassengers = lists:sort(Passengers),
    latest_time_catch_the_bus_helper(SortedBuses, SortedPassengers, Capacity, 0).

latest_time_catch_the_bus_helper([Bus|RestBuses], Passengers, Capacity, LastValid) ->
    {NewPassengers, Count} = take_passengers(Bus, Passengers, Capacity, 0),
    case RestBuses of
        [] ->
            find_latest_time(Bus, NewPassengers, Capacity - Count, LastValid);
        _ ->
            latest_time_catch_the_bus_helper(RestBuses, NewPassengers, Capacity, LastValid)
    end;
latest_time_catch_the_bus_helper([], Passengers, _Capacity, LastValid) ->
    find_latest_time(0, Passengers, 0, LastValid).

take_passengers(Bus, Passengers, Capacity, Count) ->
    case Passengers of
        [Passenger|RestPassengers] ->
            if Passenger =< Bus andalso Count < Capacity ->
                take_passengers(Bus, RestPassengers, Capacity, Count + 1);
            true ->
                {Passengers, Count}
            end;
        [] ->
            {[], Count}
    end.

find_latest_time(Bus, Passengers, RemainingCapacity, LastValid) ->
    case Passengers of
        [] ->
            if RemainingCapacity > 0 ->
                Bus;
            true ->
                find_latest_time_recursive(Bus, Passengers, LastValid)
            end;
        [Passenger|_] ->
            if Passenger > Bus ->
                if RemainingCapacity > 0 ->
                    Bus;
                true ->
                    find_latest_time_recursive(Bus, Passengers, LastValid)
                end;
            true ->
                find_latest_time_recursive(Bus, Passengers, LastValid)
        end.

find_latest_time_recursive(Bus, Passengers, LastValid) ->
    find_latest_time_recursive_helper(Bus, Passengers, LastValid, sets:new()).

find_latest_time_recursive_helper(Time, Passengers, LastValid, Seen) ->
    if sets:is_element(Time, Seen) ->
        find_latest_time_recursive_helper(Time - 1, Passengers, LastValid, Seen);
    Time > 0 ->
        case lists:member(Time, Passengers) of
            true ->
                find_latest_time_recursive_helper(Time - 1, Passengers, LastValid, Seen);
            false ->
                Time
        end;
    true ->
        LastValid.