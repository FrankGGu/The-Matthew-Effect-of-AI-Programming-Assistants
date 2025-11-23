-module(solution).
-export([averageWaitingTime/1]).

averageWaitingTime(Customers) ->
    {_LastChefFreeTime, TotalWaitTime} = lists:foldl(
        fun({Arrival, Prep}, {ChefFreeTime, AccWaitTime}) ->
            ChefStartsCooking = max(ChefFreeTime, Arrival),
            OrderCompletionTime = ChefStartsCooking + Prep,
            CustomerWaitTime = OrderCompletionTime - Arrival,
            {OrderCompletionTime, AccWaitTime + CustomerWaitTime}
        end,
        {0, 0},
        Customers
    ),
    float(TotalWaitTime) / float(length(Customers)).