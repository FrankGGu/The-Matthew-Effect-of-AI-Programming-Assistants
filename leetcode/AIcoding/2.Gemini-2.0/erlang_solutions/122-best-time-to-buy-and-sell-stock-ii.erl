-module(best_time_to_buy_sell_stock_ii).
-export([max_profit/1]).

max_profit(Prices) ->
    max_profit(Prices, 0, 0).

max_profit([], _, Profit) ->
    Profit;
max_profit([Price | Rest], LastPrice, Profit) ->
    case LastPrice of
        0 ->
            max_profit(Rest, Price, Profit);
        _ ->
            case Price > LastPrice of
                true ->
                    max_profit(Rest, Price, Profit + (Price - LastPrice));
                false ->
                    max_profit(Rest, Price, Profit)
            end
    end.