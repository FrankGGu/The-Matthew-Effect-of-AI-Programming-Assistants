-spec find_radius(Houses :: [integer()], Heaters :: [integer()]) -> integer().
find_radius(Houses, Heaters) ->
    SortedHouses = lists:sort(Houses),
    SortedHeaters = lists:sort(Heaters),
    find_radius(SortedHouses, SortedHeaters, 0, 1, 0).

find_radius([], _, Radius, _, _) -> Radius;
find_radius([H | RestHouses], Heaters, Radius, HeaterIdx, PrevHeater) ->
    case HeaterIdx < length(Heaters) of
        true ->
            CurrentHeater = lists:nth(HeaterIdx, Heaters),
            if
                H =< CurrentHeater ->
                    MinDist = min(CurrentHeater - H, 
                                 case PrevHeater == 0 of 
                                     true -> CurrentHeater - H;
                                     false -> H - PrevHeater
                                 end),
                    NewRadius = max(Radius, MinDist),
                    find_radius(RestHouses, Heaters, NewRadius, HeaterIdx, PrevHeater);
                true ->
                    find_radius([H | RestHouses], Heaters, Radius, HeaterIdx + 1, CurrentHeater)
            end;
        false ->
            MinDist = H - lists:last(Heaters),
            NewRadius = max(Radius, MinDist),
            find_radius(RestHouses, Heaters, NewRadius, HeaterIdx, PrevHeater)
    end.