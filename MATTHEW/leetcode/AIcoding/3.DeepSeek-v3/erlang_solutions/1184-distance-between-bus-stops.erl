-spec distance_between_bus_stops(Distance :: [integer()], Start :: integer(), Destination :: integer()) -> integer().
distance_between_bus_stops(Distance, Start, Destination) ->
    S = min(Start, Destination),
    D = max(Start, Destination),
    Total = lists:sum(Distance),
    Clockwise = lists:sum(lists:sublist(Distance, S + 1, D - S)),
    min(Clockwise, Total - Clockwise).