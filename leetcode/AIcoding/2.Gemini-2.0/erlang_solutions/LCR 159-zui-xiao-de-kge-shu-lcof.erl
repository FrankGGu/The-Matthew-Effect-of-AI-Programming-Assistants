-module(stock_management_iii).
-export([stock_levels/1]).

stock_levels(transactions) ->
  stock_levels(transactions, []).

stock_levels([], Acc) ->
  lists:reverse(Acc);
stock_levels([{add, Item, Quantity} | Rest], Acc) ->
  stock_levels(Rest, update_stock(Item, Quantity, Acc));
stock_levels([{remove, Item, Quantity} | Rest], Acc) ->
  stock_levels(Rest, update_stock(Item, -Quantity, Acc)).

update_stock(Item, Quantity, Acc) ->
  case lists:keyfind(Item, 1, Acc) of
    {Item, CurrentQuantity} ->
      lists:keyreplace(Item, 1, Acc, {Item, CurrentQuantity + Quantity});
    false ->
      [{Item, Quantity} | Acc]
  end.