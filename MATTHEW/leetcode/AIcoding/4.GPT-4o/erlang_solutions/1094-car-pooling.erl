-module(solution).
-export([car_pooling/2]).

car_pooling(Rides, Capacity) ->
    Events = lists:foldl(fun({Start, End, Num}, Acc) ->
        [{Start, Num} | [{End, -Num} | Acc]]
    end, [], Rides),
    SortedEvents = lists:sort(fun({Time1, _}, {Time2, _}) -> Time1 =< Time2 end, Events),
    car_pooling_helper(SortedEvents, Capacity, 0).

car_pooling_helper([], _, _) -> true;
car_pooling_helper([{_, Num} | Rest], Capacity, Current) ->
    NewCurrent = Current + Num,
    if NewCurrent > Capacity -> false;
       true -> car_pooling_helper(Rest, Capacity, NewCurrent)
    end.