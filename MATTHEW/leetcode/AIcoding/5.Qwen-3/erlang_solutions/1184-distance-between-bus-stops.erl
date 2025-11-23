-module(distance_between_bus_stops).
-export([distance_between_bus_stops/2]).

distance_between_bus_stops(Stops, {Start, Destination}) ->
    StartIndex = lists:member(Start, Stops),
    DestinationIndex = lists:member(Destination, Stops),
    if
        StartIndex == false; DestinationIndex == false -> -1;
        true ->
            StartPos = lists:foldl(fun({Idx, Val}, Acc) when Val == Start -> {true, Idx}; (_, Acc) -> Acc end, {false, -1}, lists:zip(lists:seq(0, length(Stops)-1), Stops)),
            DestPos = lists:foldl(fun({Idx, Val}, Acc) when Val == Destination -> {true, Idx}; (_, Acc) -> Acc end, {false, -1}, lists:zip(lists:seq(0, length(Stops)-1), Stops)),
            {_, S} = StartPos,
            {_, D} = DestPos,
            if
                S < D -> lists:sublist(Stops, S+1, D - S);
                true -> lists:sublist(Stops, D+1, S - D)
            end,
            Dist1 = lists:sum(lists:sublist(Stops, S+1, D - S)),
            Dist2 = lists:sum(lists:sublist(Stops, D+1, S - D)),
            min(Dist1, Dist2)
            end.