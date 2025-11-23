-module(minimum_time_to_complete_trips).
-export([num_trips/2]).

num_trips(Times, T) ->
    Left = 0,
    Right = lists:max(Times) * T,
    find_min_time(Times, T, Left, Right).

find_min_time(_, T, L, R) when L >= R ->
    L;
find_min_time(Times, T, L, R) ->
    Mid = (L + R) div 2,
    Total = total_trips(Times, Mid),
    if
        Total >= T ->
            find_min_time(Times, T, L, Mid);
        true ->
            find_min_time(Times, T, Mid + 1, R)
    end.

total_trips(_, 0) ->
    0;
total_trips(Times, Time) ->
    lists:sum([Time div T || T <- Times]).