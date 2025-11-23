-module(best_time_to_buy_and_sell_stock_with_cooldown).
-export([max_profit/1]).

max_profit(Prices) ->
    max_profit(Prices, 0, -infinity, 0).

max_profit([], _Hold, _NotHold, _Cooldown) ->
    max(NotHold, Cooldown);
max_profit([Price | Rest], Hold, NotHold, Cooldown) ->
    NewHold = max(Hold, NotHold - Price),
    NewNotHold = max(NotHold, Cooldown),
    NewCooldown = Hold + Price,
    max_profit(Rest, NewHold, NewNotHold, NewCooldown).