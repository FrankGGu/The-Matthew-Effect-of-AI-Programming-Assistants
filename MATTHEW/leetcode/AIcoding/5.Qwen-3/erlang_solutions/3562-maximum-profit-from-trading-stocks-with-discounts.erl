-module(trading_stocks).
-export([max_profit/1]).

max_profit(Prices) ->
    max_profit(Prices, 0, 0, 0).

max_profit([], _, _, Profit) ->
    Profit;
max_profit([Price | Rest], Hold, NotHold, Profit) ->
    NewHold = max(Hold, NotHold - Price),
    NewNotHold = max(NotHold, Hold + Price),
    max_profit(Rest, NewHold, NewNotHold, max(Profit, NewNotHold)).