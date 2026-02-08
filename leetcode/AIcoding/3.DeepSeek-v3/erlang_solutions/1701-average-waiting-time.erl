-spec average_waiting_time(Customers :: [[integer()]]) -> float().
average_waiting_time(Customers) ->
    {TotalWaitingTime, _} = lists:foldl(
        fun([Arrival, Time], {Sum, CurrentTime}) ->
            StartTime = max(Arrival, CurrentTime),
            NewCurrentTime = StartTime + Time,
            WaitingTime = NewCurrentTime - Arrival,
            {Sum + WaitingTime, NewCurrentTime}
        end,
        {0, 0},
        Customers
    ),
    TotalWaitingTime / length(Customers).