-module(solution).
-export([find_lucky/1]).

find_lucky(Arr) ->
    FreqMap = lists:foldl(
        fun(N, AccMap) ->
            maps:update_with(N, fun(Count) -> Count + 1 end, 1, AccMap)
        end,
        maps:new(),
        Arr
    ),

    maps:fold(
        fun(Num, Count, CurrentMaxLucky) ->
            if
                Num == Count, Num > CurrentMaxLucky ->
                    Num;
                true ->
                    CurrentMaxLucky
            end
        end,
        -1,
        FreqMap
    ).