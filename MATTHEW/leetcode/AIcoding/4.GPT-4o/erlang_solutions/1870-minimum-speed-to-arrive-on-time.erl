-module(solution).
-export([min_speed_on_time/2]).

min_speed_on_time(D, H) ->
    MinSpeed = binary_search(1, 10^7, D, H),
    if MinSpeed =:= 10^7 -> -1; true -> MinSpeed end.

binary_search(Low, High, D, H) when Low < High ->
    Mid = (Low + High) div 2,
    if can_arrive(Mid, D, H) -> 
        binary_search(Low, Mid);
    true -> 
        binary_search(Mid + 1, High)
    end;
binary_search(Low, High, _, _) -> Low.

can_arrive(Speed, Distances, Hour) ->
    TotalTime = lists:foldl(fun(Distance, Acc) -> 
        Acc + ceil(Distance / Speed) 
    end, 0, Distances),
    TotalTime =< Hour.