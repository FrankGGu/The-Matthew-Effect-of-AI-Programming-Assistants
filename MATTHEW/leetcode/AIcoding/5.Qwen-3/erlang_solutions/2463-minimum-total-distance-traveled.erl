-module(minimum_total_distance_traveled).
-export([minimumTotalDistance/1]).

minimumTotalDistance(Stats) ->
    [Robots | [Chargers | _]] = Stats,
    RobotsSorted = lists:sort(Robots),
    ChargersSorted = lists:sort(Chargers),
    solve(RobotsSorted, ChargersSorted).

solve([], _) -> 0;
solve(_, []) -> 0;
solve([R | Rs], [C | Cs]) ->
    Distance = abs(R - C),
    Distance + solve(Rs, Cs).