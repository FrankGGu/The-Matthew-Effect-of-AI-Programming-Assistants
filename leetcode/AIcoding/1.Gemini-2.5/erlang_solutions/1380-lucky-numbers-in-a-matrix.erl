-module(solution).
-export([lucky_numbers_in_a_matrix/1]).

lucky_numbers_in_a_matrix(Matrix) ->
    NumRows = length(Matrix),
    NumCols = length(hd(Matrix)),

    RowMins = [lists:min(Row) || Row <- Matrix],

    ColMaxes =
        [lists:max([lists:nth(CIndex, Row) || Row <- Matrix])
         || CIndex <- lists:seq(1, NumCols)],

    LuckyNumbers =
        [Element ||
            RIndex <- lists:seq(1, NumRows),
            Row = lists:nth(RIndex, Matrix),
            CIndex <- lists:seq(1, NumCols),
            Element = lists:nth(CIndex, Row),
            Element == lists:nth(RIndex, RowMins),
            Element == lists:nth(CIndex, ColMaxes)
        ],
    LuckyNumbers.