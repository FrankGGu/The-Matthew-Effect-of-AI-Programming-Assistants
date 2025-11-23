-module(solution).
-export([min_time_to_rearrange_binary_string/1]).

min_time_to_rearrange_binary_string(S) ->
    min_time_to_rearrange_binary_string(S, 0, 0).

min_time_to_rearrange_binary_string([], _, Time) ->
    Time;
min_time_to_rearrange_binary_string([H | T], Count, Time) ->
    if
        H == $0 ->
            min_time_to_rearrange_binary_string(T, Count + 1, Time);
        true ->
            NewTime = max(Time + 1, Count),
            min_time_to_rearrange_binary_string(T, Count, NewTime)
    end.