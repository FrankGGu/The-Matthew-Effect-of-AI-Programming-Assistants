-module(minimum_speed).
-export([min_speed_on_time/2]).

min_speed_on_time(Dist, Hour) ->
    min_speed_on_time(Dist, Hour, 1, 10000000).

min_speed_on_time(Dist, Hour, Low, High) ->
    if Low > High ->
        -1;
    true ->
        Mid = (Low + High) div 2,
        Time = calculate_time(Dist, Mid),
        if Time > Hour ->
            min_speed_on_time(Dist, Hour, Mid + 1, High);
        true ->
            if Mid == Low ->
                if calculate_time(Dist, Mid) =< Hour ->
                    Mid;
                true ->
                    min_speed_on_time(Dist, Hour, Mid + 1, High)
                end;
            true ->
                if calculate_time(Dist, Mid - 1) > Hour ->
                    Mid;
                true ->
                    min_speed_on_time(Dist, Hour, Low, Mid - 1)
                end
            end
        end
    end.

calculate_time(Dist, Speed) ->
    calculate_time(Dist, Speed, 0, 1).

calculate_time([H|T], Speed, Acc, _) ->
    NewAcc = Acc + math:ceil(H / Speed),
    calculate_time(T, Speed, NewAcc, 0);
calculate_time([], Speed, Acc, 0) ->
    Acc;
calculate_time([], Speed, Acc, 1) ->
    Acc - math:ceil(lists:last(Dist) / Speed) + (lists:last(Dist) / Speed).