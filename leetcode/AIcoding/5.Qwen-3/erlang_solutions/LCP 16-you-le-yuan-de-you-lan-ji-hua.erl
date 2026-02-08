-module(ride_plan).
-export([max_rides/1]).

max_rides(Rides) ->
    max_rides(Rides, 0, 0).

max_rides([], Acc, _) ->
    Acc;
max_rides([H|T], Acc, LastTime) ->
    [Start, End] = H,
    if
        Start >= LastTime ->
            max_rides(T, Acc + 1, End);
        true ->
            max_rides(T, Acc, LastTime)
    end.