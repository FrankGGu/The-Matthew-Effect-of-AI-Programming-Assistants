-module(solution).
-export([time_needed_to_buy/2]).

time_needed_to_buy(Tickets, K) ->
    TotalTime = lists:sum(lists:map(fun(N) -> min(N, Tickets[K]) end, Tickets)),
    TotalTime + lists:sum(lists:filter(fun(N) -> N > Tickets[K] end, Tickets)).