-module(solution).
-export([subarray_sum_square/1]).

subarray_sum_square(List) ->
    N = length(List),
    DistinctCount = fun(List) ->
        lists:usort(List),
        length(lists:usort(List))
    end,
    SumSquares = fun(Start, End) ->
        Sub = lists:sublist(List, Start, End - Start + 1),
        DistinctCount(Sub) * DistinctCount(Sub)
    end,
    Total = lists:sum(
        [SumSquares(Start, End) || Start <- lists:seq(1, N), End <- lists:seq(Start, N)]
    ),
    Total.