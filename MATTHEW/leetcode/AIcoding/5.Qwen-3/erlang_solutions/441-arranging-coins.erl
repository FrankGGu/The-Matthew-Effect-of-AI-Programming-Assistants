-module(arranging_coins).
-export([arrange_coins/1]).

arrange_coins(N) ->
    arrange_coins(N, 1).

arrange_coins(N, K) when N < K -> 0;
arrange_coins(N, K) ->
    Remaining = N - K,
    1 + arrange_coins(Remaining, K + 1).