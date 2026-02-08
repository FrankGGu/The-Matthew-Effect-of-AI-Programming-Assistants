-module(car_fleet).
-export([car_fleet/2]).

car_fleet(Target, Position) ->
    Sorted = lists:sort(fun({Pos1, _}, {Pos2, _}) -> Pos1 > Pos2 end, lists:zip(Position, lists:seq(1, length(Position))),
    Distances = lists:map(fun({Pos, _}) -> Target - Pos end, Sorted),
    Times = lists:map(fun({Distance, Speed}) -> Distance / Speed end, lists:zip(Distances, lists:map(fun(_) -> 1 end, Sorted))),
    Grouped = lists:foldl(fun(Time, {LastTime, Count}) ->
        case LastTime of
            undefined -> {Time, 1};
            _ when Time > LastTime -> {Time, Count + 1};
            _ -> {LastTime, Count}
        end
    end, {undefined, 0}, Times),
    element(2, Grouped).