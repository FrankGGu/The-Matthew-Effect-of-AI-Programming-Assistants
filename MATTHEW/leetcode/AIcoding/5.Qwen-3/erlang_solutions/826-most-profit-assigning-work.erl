-module(most_profit_assigning_work).
-export([max_profit_assignment/2]).

max_profit_assignment(Work, Profit) ->
    max_profit_assignment(Work, Profit, 0, 0, 0).

max_profit_assignment([], _, _, _, Acc) ->
    Acc;
max_profit_assignment([W | Rest], [P | RestP], CurrentWork, CurrentProfit, Acc) ->
    if
        W > CurrentWork ->
            max_profit_assignment(Rest, RestP, W, P, Acc + CurrentProfit);
        true ->
            max_profit_assignment(Rest, RestP, CurrentWork, CurrentProfit, Acc)
    end.