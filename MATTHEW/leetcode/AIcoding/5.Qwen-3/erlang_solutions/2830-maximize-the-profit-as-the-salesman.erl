-module(solution).
-export([max_profit/2]).

max_profit(Prices, K) ->
    max_profit(Prices, K, 0, 0, 0).

max_profit(_, 0, _, _, Acc) ->
    Acc;
max_profit([], _, _, _, Acc) ->
    Acc;
max_profit([Price | Rest], K, Buy, Sell, Acc) ->
    case Buy of
        0 ->
            NewAcc = max(Acc, max_profit(Rest, K, Price, Sell, Acc)),
            max_profit(Rest, K, Buy, Sell, NewAcc);
        _ ->
            NewAcc = max(Acc, Price - Buy),
            max_profit(Rest, K, Buy, Price, NewAcc)
    end.