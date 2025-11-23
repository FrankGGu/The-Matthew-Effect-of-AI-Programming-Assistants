-module(solution).
-export([max_price/2]).

max_price(Prices, K) ->
    max_price(Prices, K, 0).

max_price([], _, Max) ->
    Max;
max_price([H | T], K, Max) when H =< K ->
    max_price(T, K - H, max(Max, H));
max_price([_ | T], K, Max) ->
    max_price(T, K, Max).