-module(solution).
-export([max_profit/2]).

max_profit(Prices, Fee) ->
    max_profit_helper(Prices, 0, 0, Fee).

max_profit_helper([], Cash, Held, _) ->
    Cash;
max_profit_helper([Price | Rest], Cash, Held, Fee) ->
    NewCash = max(Cash, Held + Price - Fee),
    NewHeld = max(Held, Cash - Price),
    max_profit_helper(Rest, NewCash, NewHeld, Fee).