-module(solution).
-export([average_waiting_time/1]).

average_waiting_time/1 ->
    Times = lists:map(fun({Arrival, Duration}) -> {Arrival, Duration} end, Input),
    TotalWait = calculate_waiting_time(Times, 0, 0, 0),
    TotalJobs = length(Times),
    TotalWait / TotalJobs.

calculate_waiting_time([], _, TotalWait, _) -> TotalWait;
calculate_waiting_time([{Arrival, Duration} | Rest], CurrentTime, TotalWait, Completed) ->
    NewTime = max(CurrentTime, Arrival) + Duration,
    calculate_waiting_time(Rest, NewTime, TotalWait + (NewTime - Arrival), Completed + 1).