-spec find_delayed_arrival_time(ArrivalTime :: integer(), DelayedTime :: integer()) -> integer().
find_delayed_arrival_time(ArrivalTime, DelayedTime) ->
    (ArrivalTime + DelayedTime) rem 24.