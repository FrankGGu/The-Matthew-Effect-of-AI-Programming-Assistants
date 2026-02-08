-module(best_time_to_buy_sell_stock_iii).
-export([max_profit/1]).

max_profit(Prices) ->
  max_profit_helper(Prices, 0, 0, 0, 0, 0).

max_profit_helper([], Buy1, Sell1, Buy2, Sell2, Count) ->
  max(Sell2, 0);

max_profit_helper([Price | Rest], Buy1, Sell1, Buy2, Sell2, Count) ->
  New_Buy1 = min(Buy1, Price),
  New_Sell1 = max(Sell1, Price - Buy1),
  New_Buy2 = min(Buy2, Price - New_Sell1),
  New_Sell2 = max(Sell2, Price - Buy2),
  max_profit_helper(Rest, New_Buy1, New_Sell1, New_Buy2, New_Sell2, Count + 1).

max(A, B) ->
  if A > B -> A;
     true -> B
  end.

min(A, B) ->
  if A < B -> A;
     true -> B
  end.