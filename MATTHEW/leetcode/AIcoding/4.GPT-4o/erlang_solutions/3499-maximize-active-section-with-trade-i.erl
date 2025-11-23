-module(solution).
-export([max_profit/2]).

max_profit(Prices, Fee) ->
    max_profit_helper(Prices, Fee, 0, 0).

max_profit_helper([], _, Cash, _Stock) -> 
    Cash;
max_profit_helper([Price | Rest], Fee, Cash, Stock) ->
    NewCash = max(Cash, Stock + Price - Fee),
    NewStock = max(Stock, Cash - Price),
    max_profit_helper(Rest, Fee, NewCash, NewStock).