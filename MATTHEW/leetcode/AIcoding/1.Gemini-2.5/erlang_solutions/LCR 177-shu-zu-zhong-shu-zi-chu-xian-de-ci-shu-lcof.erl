-module(solution).
-export([solve/1]).

solve(Colors) ->
    N = length(Colors),
    TotalPairs = N * (N - 1) div 2,

    FreqMap = lists:foldl(
        fun(Color, Acc) ->
            maps:update_with(Color, fun(Count) -> Count + 1 end, 1, Acc)
        end,
        maps:new(),
        Colors
    ),

    SameColorPairs = maps:fold(
        fun(_Color, Count, Acc) ->
            Acc + (Count * (Count - 1) div 2)
        end,
        0,
        FreqMap
    ),

    TotalPairs - SameColorPairs.