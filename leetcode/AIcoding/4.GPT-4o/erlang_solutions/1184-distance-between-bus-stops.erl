-module(solution).
-export([distance_between_bus_stops/2]).

distance_between_bus_stops(Distances, Start, Destination) ->
    Total = lists:sum(Distances),
    Forward = lists:sum(lists:sublist(Distances, Start, Destination - Start)),
    min(Forward, Total - Forward).