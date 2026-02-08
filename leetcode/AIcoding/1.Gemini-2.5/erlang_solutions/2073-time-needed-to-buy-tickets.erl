-module(solution).
-export([timeNeededToBuyTickets/2]).

timeNeededToBuyTickets(Tickets, K) ->
    KthPersonTickets = lists:nth(K + 1, Tickets),
    calculate_time(Tickets, K, KthPersonTickets, 0, 0).

calculate_time([], _K, _KthPersonTickets, _CurrentIndex, TotalTime) ->
    TotalTime;
calculate_time([CurrentPersonTickets | RestTickets], K, KthPersonTickets, CurrentIndex, AccTime) ->
    Contribution = 
        if
            CurrentIndex =< K ->
                min(CurrentPersonTickets, KthPersonTickets);
            true ->
                min(CurrentPersonTickets, KthPersonTickets - 1)
        end,
    calculate_time(RestTickets, K, KthPersonTickets, CurrentIndex + 1, AccTime + Contribution).