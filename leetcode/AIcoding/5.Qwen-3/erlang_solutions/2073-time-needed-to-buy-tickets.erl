-module(time_needed_to_buy_tickets).
-export([time_required_to_buy_tickets/2]).

time_required_to_buy_tickets(Tickets, k) ->
    time_required_to_buy_tickets(Tickets, k, 0, 0).

time_required_to_buy_tickets([], _, _, Acc) ->
    Acc;
time_required_to_buy_tickets([H | T], K, Index, Acc) ->
    if
        Index == K ->
            Acc + H;
        true ->
            time_required_to_buy_tickets(T, K, Index + 1, Acc + min(H, lists:nth(Index + 1, T)))
    end.