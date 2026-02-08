-module(solution).
-export([findDelayedArrivalTime/2]).

findDelayedArrivalTime(ArrivalTime, delayedTime) ->
    (ArrivalTime + delayedTime) rem 24.