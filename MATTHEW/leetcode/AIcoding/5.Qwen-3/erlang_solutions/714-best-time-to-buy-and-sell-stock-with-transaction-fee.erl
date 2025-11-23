-module(solve).
-export([max_profit/1]).

max_profit(Prices) ->
    max_profit(Prices, 0, -hd(Prices)).

max_profit([], Cash, Hold) ->
    Cash;
max_profit([Price | Tail], Cash, Hold) ->
    NewCash = max(Cash, Hold + Price - 2),
    NewHold = max(Hold, Cash - Price),
    max_profit(Tail, NewCash, NewHold).