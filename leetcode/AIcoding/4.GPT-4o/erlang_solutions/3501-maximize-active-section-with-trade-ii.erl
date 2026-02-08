-module(solution).
-export([max_profit/2]).

max_profit(Prices, K) ->
    N = length(Prices),
    if K > N div 2 -> max_profit_unlimited(Prices);
       true -> max_profit_limited(Prices, K)
    end.

max_profit_unlimited(Prices) ->
    lists:foldl(fun({P1, P2}) -> P2 - P1 end, 0, lists:zip(Prices, tl(Prices))).

max_profit_limited(Prices, K) ->
    N = length(Prices),
    Profits = lists:duplicate(N + 1, 0),
    lists:foldl(fun({P, i}) -> update_profits(Profits, P, i, K) end, {0, Profits}, lists:zip(Prices, lists:seq(0, N - 1))).

update_profits(Profits, P, I, K) ->
    MaxProfit = lists:foldl(fun(J, Acc) -> max(Acc, Profits/J + max(0, P - lists:nth(J + 1, Profits))) end, 0, lists:seq(0, K)),
    Profits/I + MaxProfit.