-module(minimum_money).
-export([minimumMoney/1]).

minimumMoney(Transactions) ->
  minimum_money(Transactions, 0, 0).

minimum_money([], MaxCost, CurrentMoney) ->
  max(MaxCost, CurrentMoney);

minimum_money([Transaction | Rest], MaxCost, CurrentMoney) ->
  [Cost, Cash] = Transaction,
  if Cost > Cash ->
    minimum_money(Rest, MaxCost + (Cost - Cash), CurrentMoney + Cash)
  else ->
    minimum_money(Rest, MaxCost, CurrentMoney + Cost)
  end.