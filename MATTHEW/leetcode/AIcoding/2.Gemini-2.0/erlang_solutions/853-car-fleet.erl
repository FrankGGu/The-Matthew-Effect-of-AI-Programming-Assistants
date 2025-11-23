-module(car_fleet).
-export([car_fleet/2]).

car_fleet(Target, Position, Speed) ->
    Cars = lists:zip(Position, Speed),
    SortedCars = lists:sort(fun({P1, _}, {P2, _}) -> P1 > P2 end, Cars),
    FoldFun = fun({Pos, Speed}, {Stack, Fleet}) ->
        Time = (Target - Pos) / Speed,
        case Stack of
            [] ->
                { [Time], Fleet + 1 };
            [Top | _] ->
                if Time > Top then
                    { [Time | Stack], Fleet + 1 }
                else
                    { Stack, Fleet }
                end
        end
    end,
    {_, Fleet} = lists:foldl(FoldFun, {[], 0}, SortedCars),
    Fleet.