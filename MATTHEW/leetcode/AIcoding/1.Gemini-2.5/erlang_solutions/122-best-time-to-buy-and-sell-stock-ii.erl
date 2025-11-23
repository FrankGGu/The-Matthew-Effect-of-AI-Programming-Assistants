-module(solution).
-export([max_profit/1]).

max_profit([]) -> 0;
max_profit([_]) -> 0;
max_profit(Prices) ->
    max_profit(Prices, 0).

max_profit([_], Acc) -> Acc;
max_profit([BuyPrice, SellPrice | Rest], Acc) ->
    case SellPrice > BuyPrice of
        true ->
            max_profit([SellPrice | Rest], Acc + (SellPrice - BuyPrice));
        false ->
            max_profit([SellPrice | Rest], Acc)
    end.