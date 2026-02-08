-module(special_positions).
-export([num_special/1]).

num_special(Mat) ->
    Rows = length(Mat),
    Cols = length(hd(Mat)),
    RowSums = lists:map(fun(Row) -> lists:sum(Row) end, Mat),
    ColSums =
        lists:foldl(
            fun(Row, Acc) ->
                lists:zipwith(fun(X, Y) -> X + Y end, Row, Acc)
            end,
            lists:duplicate(Cols, 0),
            Mat
        ),
    count_special(Mat, RowSums, ColSums, 0, 0, 0).

count_special(_Mat, _RowSums, _ColSums, Rows, _Cols, Count) when Rows =:= length(_Mat) ->
    Count;
count_special(Mat, RowSums, ColSums, RowIndex, ColIndex, Count) ->
    case lists:nth(ColIndex + 1, lists:nth(RowIndex + 1, Mat)) of
        1 ->
            if lists:nth(RowIndex + 1, RowSums) =:= 1 andalso lists:nth(ColIndex + 1, ColSums) =:= 1 then
                NewCount = Count + 1
            else
                NewCount = Count
            end,
            NextColIndex = ColIndex + 1,
            if NextColIndex =:= length(hd(Mat)) then
                count_special(Mat, RowSums, ColSums, RowIndex + 1, 0, NewCount)
            else
                count_special(Mat, RowSums, ColSums, RowIndex, NextColIndex, NewCount)
            end;
        0 ->
            NextColIndex = ColIndex + 1,
            if NextColIndex =:= length(hd(Mat)) then
                count_special(Mat, RowSums, ColSums, RowIndex + 1, 0, Count)
            else
                count_special(Mat, RowSums, ColSums, RowIndex, NextColIndex, Count)
            end
    end.