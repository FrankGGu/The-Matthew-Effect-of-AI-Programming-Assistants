-module(minimum_speed_to_arrive_on_time).
-export([minSpeedOnTime/2]).

minSpeedOnTime(Paths, Hour) ->
    min_speed(Paths, Hour, 1, lists:max(Paths)).

min_speed(_, _, Low, High) when Low >= High ->
    Low;
min_speed(Paths, Hour, Low, High) ->
    Mid = (Low + High) div 2,
    Time = calculate_time(Paths, Mid),
    if
        Time =< Hour ->
            min_speed(Paths, Hour, Low, Mid);
        true ->
            min_speed(Paths, Hour, Mid + 1, High)
    end.

calculate_time([], _) ->
    0.0;
calculate_time([D | T], Speed) ->
    Time = math:ceil(D / Speed),
    Time + calculate_time(T, Speed).