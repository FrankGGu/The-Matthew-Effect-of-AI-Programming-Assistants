-module(average_waiting_time).
-export([average_waiting_time/1]).

average_waiting_time(Customers) ->
    {TotalWaitingTime, _} = lists:foldl(
        fun({ArrivalTime, ServiceTime}, {AccWaitingTime, LastEndTime}) ->
            StartTime = max(ArrivalTime, LastEndTime),
            EndTime = StartTime + ServiceTime,
            WaitingTime = EndTime - ArrivalTime,
            {AccWaitingTime + WaitingTime, EndTime}
        end,
        {0, 0},
        Customers
    ),
    TotalWaitingTime / length(Customers).