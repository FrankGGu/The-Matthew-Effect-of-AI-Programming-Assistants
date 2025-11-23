-module(solution).
-export([max_balls/2]).

max_balls(LowLimit, HighLimit) ->
    Counts = count_balls_recursive(LowLimit, HighLimit, #{}),
    lists:max(maps:values(Counts)).

count_balls_recursive(N, HighLimit, AccCounts) when N =< HighLimit ->
    BoxNum = sum_digits(N),
    CurrentCount = maps:get(BoxNum, AccCounts, 0),
    NewAccCounts = maps:put(BoxNum, CurrentCount + 1, AccCounts),
    count_balls_recursive(N + 1, HighLimit, NewAccCounts);
count_balls_recursive(_N, _HighLimit, AccCounts) ->
    AccCounts.

sum_digits(0) -> 0;
sum_digits(N) -> (N rem 10) + sum_digits(N div 10).