-module(car_fleet).
-export([car_fleet/2]).

car_fleet(Positions, Speeds) ->
    Lists = lists:zip(Positions, Speeds),
    Sorted = lists:sort(fun({P1, _}, {P2, _}) -> P1 > P2 end, Lists),
    Time = [ (Pos - 1000000000) / Speed || {Pos, Speed} <- Sorted ],
    car_fleet(Time, []).

car_fleet([], Acc) ->
    length(Acc);
car_fleet([T | Ts], []) ->
    car_fleet(Ts, [T]);
car_fleet([T | Ts], [H | _] = Acc) when T =< H ->
    car_fleet(Ts, Acc);
car_fleet([T | Ts], [H | _] = Acc) ->
    car_fleet(Ts, [T | Acc]).