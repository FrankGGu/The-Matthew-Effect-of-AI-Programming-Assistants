-module(solution).
-export([make_equal/1]).

make_equal(Words) ->
    N = length(Words),
    InitialCounts = maps:new(),
    FinalCounts = lists:foldl(
        fun(Word, AccCounts) ->
            lists:foldl(
                fun(Char, CurrentCounts) ->
                    maps:update_with(Char, fun(Count) -> Count + 1 end, 1, CurrentCounts)
                end,
                AccCounts,
                Word
            )
        end,
        InitialCounts,
        Words
    ),
    maps:foldl(
        fun(_Char, Count, AccResult) ->
            AccResult andalso (Count rem N == 0)
        end,
        true,
        FinalCounts
    ).