-module(minimum_coins).
-export([minimum_added_coins/1]).

minimum_added_coins(coins) ->
  minimum_added_coins(lists:sort(coins), 0, 1).

minimum_added_coins([], Count, _Reach) ->
  Count;
minimum_added_coins([Coin | Rest], Count, Reach) ->
  if
    Coin > Reach ->
      minimum_added_coins([Coin | Rest], Count + 1, Reach * 2);
    true ->
      minimum_added_coins(Rest, Count, Reach + Coin)
  end.