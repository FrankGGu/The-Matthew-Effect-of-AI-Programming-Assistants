-module(arranging_coins).
-export([arrangeCoins/1]).

arrangeCoins(N) ->
  floor((math:sqrt(1 + 8 * N) - 1) / 2).