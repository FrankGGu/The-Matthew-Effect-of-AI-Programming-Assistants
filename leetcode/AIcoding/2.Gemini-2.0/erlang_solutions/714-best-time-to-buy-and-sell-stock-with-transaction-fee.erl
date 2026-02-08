-module(best_time_to_buy_sell_stock_with_fee).
-export([max_profit/2]).

max_profit(Prices, Fee) ->
  max_profit_helper(Prices, Fee, 0, false).

max_profit_helper([], _Fee, Profit, _Holding) ->
  Profit;
max_profit_helper([Price|Rest], Fee, Profit, false) ->
  max(
    max_profit_helper(Rest, Fee, Profit, false),
    max_profit_helper(Rest, Fee, Profit - Price, true)
  );
max_profit_helper([Price|Rest], Fee, Profit, true) ->
  max(
    max_profit_helper(Rest, Fee, Profit, true),
    max_profit_helper(Rest, Fee, Profit + Price - Fee, false)
  ).