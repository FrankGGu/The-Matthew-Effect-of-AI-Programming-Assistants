-module(car_pooling).
-export([car_pooling/1]).

car_pooling(Pickups) ->
    Events = lists:foldl(fun({Passengers, Start, End}, Acc) ->
        [{Start, Passengers} | {End, -Passengers} | Acc]
    end, [], Pickups),
    SortedEvents = lists:sort(Events),
    CurrentPassengers = 0,
    MaxPassengers = 0,
    car_pooling_helper(SortedEvents, CurrentPassengers, MaxPassengers).

car_pooling_helper([], _, Max) ->
    Max;
car_pooling_helper([{Pos, Delta} | Rest], Current, Max) ->
    NewCurrent = Current + Delta,
    NewMax = max(Max, NewCurrent),
    car_pooling_helper(Rest, NewCurrent, NewMax).