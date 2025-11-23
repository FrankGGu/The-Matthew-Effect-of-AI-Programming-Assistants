-module(solution).
-export([max_profit/1]).

-spec max_profit(Prices :: [integer()]) -> integer().
max_profit(Prices) ->
    max_profit_impl(Prices, infinity, 0).

max_profit_impl([], _MinPrice, MaxProfit) ->
    MaxProfit;
max_profit_impl([CurrentPrice|RestPrices], MinPriceSeenSoFar, CurrentMaxProfit) ->
    NewMinPrice = custom_min(MinPriceSeenSoFar, CurrentPrice),
    PotentialProfit = CurrentPrice - NewMinPrice,
    NewMaxProfit = erlang:max(CurrentMaxProfit, PotentialProfit),
    max_profit_impl(RestPrices, NewMinPrice, NewMaxProfit).

custom_min(infinity, Val) -> Val;
custom_min(Val, infinity) -> Val;
custom_min(Val1, Val2) -> erlang:min(Val1, Val2).