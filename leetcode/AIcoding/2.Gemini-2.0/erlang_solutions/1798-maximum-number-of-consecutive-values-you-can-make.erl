-module(maximum_consecutive).
-export([maximum_consecutive_values/1]).

maximum_consecutive_values(Coins) ->
  lists:foldl(fun(Coin, Max) ->
    if Coin =< Max + 1 then
      Max + Coin
    else
      Max
    end
  end, 0, lists:sort(Coins)).