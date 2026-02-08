-module(solution).
-export([maxProfit/2]).

maxProfit(N, rides) ->
    maxProfitHelper(N, rides, 0, 0).

maxProfitHelper(_, [], Profit, _) ->
    Profit;
maxProfitHelper(N, [Ride | Rest], Profit, Count) ->
    NewCount = Count + 1,
    NewProfit = Profit + max(0, Ride - NewCount),
    maxProfitHelper(N, Rest, NewProfit, NewCount).