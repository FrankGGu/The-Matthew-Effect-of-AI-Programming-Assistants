-module(solution).
-export([max_value/3]).

max_value(N, index, max) when N > 0, index >= 0, max > 0 ->
    Min = max - index,
    Max = max - (N - 1 - index),
    Min =< Max, Min >= 0,
    Sum = (Max - Min + 1) * (Min + Max) div 2,
    Sum + (N - 1) * (N - 1) div 2.

max_value(_, _, _) ->
    0.