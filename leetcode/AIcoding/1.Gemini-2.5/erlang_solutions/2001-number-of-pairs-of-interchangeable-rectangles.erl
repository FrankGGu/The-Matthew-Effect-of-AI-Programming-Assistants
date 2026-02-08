-module(solution).
-export([interchangeable_rectangles/1]).

interchangeable_rectangles(Rectangles) ->
    RatioCounts = lists:foldl(
        fun([W, H], AccMap) ->
            GCD = math:gcd(W, H),
            ReducedW = W div GCD,
            ReducedH = H div GCD,
            RatioKey = {ReducedW, ReducedH},
            maps:update_with(RatioKey, fun(Count) -> Count + 1 end, 1, AccMap)
        end,
        #{},
        Rectangles
    ),
    maps:foldl(
        fun(_Key, Count, AccSum) ->
            AccSum + (Count * (Count - 1) div 2)
        end,
        0,
        RatioCounts
    ).