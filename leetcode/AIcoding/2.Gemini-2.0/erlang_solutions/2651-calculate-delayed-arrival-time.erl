-module(solution).
-export([solve/2]).

solve(arrivalTime, delayedTime) ->
    (arrivalTime + delayedTime) rem 24.