-module(solution).
-export([car_fleet/3]).

car_fleet(Target, Position, Speed) ->
    ZippedCars = lists:zip(Position, Speed),
    SortedCars = lists:sort(fun({P1, _}, {P2, _}) -> P1 >= P2 end, ZippedCars),
    solve(SortedCars, Target, 0.0, 0).

solve([], _Target, _CurrentMaxTime, FleetCount) ->
    FleetCount;
solve([{Pos, Spd} | Rest], Target, CurrentMaxTime, FleetCount) ->
    TimeToTarget = (Target - Pos) / Spd,
    if
        TimeToTarget > CurrentMaxTime ->
            solve(Rest, Target, TimeToTarget, FleetCount + 1);
        true ->
            solve(Rest, Target, CurrentMaxTime, FleetCount)
    end.