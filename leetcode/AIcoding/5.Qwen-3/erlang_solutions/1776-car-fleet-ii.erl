-module(car_fleet_ii).
-export([car_fleet_ii/2]).

car_fleet_ii(Positions, Speeds) ->
    Cars = lists:zip(Positions, Speeds),
    SortedCars = lists:sort(fun({P1, _}, {P2, _}) -> P1 < P2 end, Cars),
    Stack = [],
    lists:foldl(fun({Pos, Speed}, Acc) ->
        TimeToTarget = (100 - Pos) / Speed,
        case Acc of
            [] -> [TimeToTarget | Acc];
            [H | T] when H >= TimeToTarget -> Acc;
            _ -> [TimeToTarget | Acc]
        end
    end, Stack, SortedCars),
    length(lists:reverse(Stack)).