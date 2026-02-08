-module(solution).
-export([minimum_time/2]).

minimum_time(Time, Fruits) ->
    Sorted = lists:sort(Fruits),
    calculate_time(Sorted, 0, 0).

calculate_time([], _, TotalTime) ->
    TotalTime;
calculate_time([H|T], PrevPos, TotalTime) ->
    Distance = abs(H - PrevPos),
    calculate_time(T, H, TotalTime + Distance).