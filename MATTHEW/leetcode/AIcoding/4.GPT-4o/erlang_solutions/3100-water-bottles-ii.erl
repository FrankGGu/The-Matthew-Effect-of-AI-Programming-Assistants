-module(solution).
-export([numWaterBottles/2]).

numWaterBottles(N, R) ->
    Total = N + (N div R),
    Bottles = Total,
    Rest = N rem R,
    case Rest of
        0 -> Bottles;
        _ -> Bottles + numWaterBottles(Rest, R)
    end.