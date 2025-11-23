-module(solution).
-export([sum_distinct_squares/1]).

sum_distinct_squares(Nums) ->
    Len = length(Nums),
    lists:foldl(
        fun(I, AccI) ->
            lists:foldl(
                fun(J, AccJ) ->
                    Subarray = lists:sublist(Nums, I, J - I + 1),
                    DistinctCount = sets:size(sets:from_list(Subarray)),
                    AccJ + (DistinctCount * DistinctCount)
                end,
                AccI,
                lists:seq(I, Len)
            )
        end,
        0,
        lists:seq(1, Len)
    ).