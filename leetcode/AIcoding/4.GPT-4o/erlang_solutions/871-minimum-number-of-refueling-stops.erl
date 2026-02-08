-module(solution).
-export([min_refuel_stops/3]).

min_refuel_stops(Target, StartFuel, Stations) ->
    MinStops = lists:foldl(fun({pos, fuel}, {stops, curr_fuel, curr_pos}) ->
        case curr_fuel + curr_pos >= Target of
            true -> {stops, curr_fuel + fuel, pos};
            false -> {stops + 1, max(curr_fuel + fuel, 0), pos}
        end
    end, {0, StartFuel, 0}, Stations),
    case MinStops of
        {stops, curr_fuel, _} -> if curr_fuel >= Target -> stops; true -> -1 end
    end.

max(A, B) -> if A > B -> A; true -> B end.