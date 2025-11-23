-module(solution).
-export([xorOfNumbersWhichAppearTwice/1]).

xorOfNumbersWhichAppearTwice(Nums) ->
    FreqMap = lists:foldl(
        fun(N, AccMap) ->
            maps:update_with(N, fun(C) -> C + 1 end, 1, AccMap)
        end,
        #{},
        Nums
    ),
    maps:foldl(
        fun(Num, Count, AccXOR) ->
            if
                Count == 2 ->
                    AccXOR bxor Num;
                true ->
                    AccXOR
            end
        end,
        0,
        FreqMap
    ).