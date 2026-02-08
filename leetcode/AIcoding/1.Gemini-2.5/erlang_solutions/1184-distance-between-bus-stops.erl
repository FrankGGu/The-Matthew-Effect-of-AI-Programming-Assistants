-spec distance_between_bus_stops(Distance :: [integer()], Start :: integer(), Destination :: integer()) -> integer().
distance_between_bus_stops(Distance, Start, Destination) ->
    TotalDistance = lists:sum(Distance),

    S_idx = min(Start, Destination),
    D_idx = max(Start, Destination),

    Path1Distance = calculate_path_distance(Distance, S_idx, D_idx - 1),

    Path2Distance = TotalDistance - Path1Distance,

    min(Path1Distance, Path2Distance).

calculate_path_distance(Distance, StartIdx, EndIdx) ->
    if
        StartIdx > EndIdx -> 0;
        true ->
            Sublist = lists:sublist(Distance, StartIdx + 1, EndIdx - StartIdx + 1),
            lists:sum(Sublist)
    end.