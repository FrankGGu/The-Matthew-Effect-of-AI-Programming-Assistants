-spec car_fleet(Target :: integer(), Position :: [integer()], Speed :: [integer()]) -> integer().
car_fleet(Target, Position, Speed) ->
    Cars = lists:zip(Position, Speed),
    SortedCars = lists:sort(fun({P1, _}, {P2, _}) -> P1 > P2 end, Cars),
    calculate_fleets(Target, SortedCars, []).

calculate_fleets(_, [], Fleets) ->
    length(Fleets);
calculate_fleets(Target, [{Pos, Spd} | Rest], []) ->
    Time = (Target - Pos) / Spd,
    calculate_fleets(Target, Rest, [Time]);
calculate_fleets(Target, [{Pos, Spd} | Rest], [FleetTime | _] = Fleets) ->
    CurrentTime = (Target - Pos) / Spd,
    if
        CurrentTime > FleetTime ->
            calculate_fleets(Target, Rest, [CurrentTime | Fleets]);
        true ->
            calculate_fleets(Target, Rest, Fleets)
    end.