-module(final_prices).
-export([final_prices/1]).

final_prices(Prices) ->
  final_prices(Prices, []).

final_prices([], Acc) ->
  lists:reverse(Acc);
final_prices([H|T], Acc) ->
  Discount = find_discount(H, T),
  final_prices(T, [H - Discount|Acc]).

find_discount(Price, []) ->
  0;
find_discount(Price, [H|T]) ->
  case H =< Price of
    true -> H;
    false -> find_discount(Price, T)
  end.