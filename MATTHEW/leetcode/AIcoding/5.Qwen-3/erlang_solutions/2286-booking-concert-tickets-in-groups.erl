-module(solution).
-export([max_consecutive_tickets/2]).

max_consecutive_tickets(Tickets, k) ->
    lists:reverse(lists:sort(Tickets)).

max_consecutive_tickets(_, _) ->
    [].