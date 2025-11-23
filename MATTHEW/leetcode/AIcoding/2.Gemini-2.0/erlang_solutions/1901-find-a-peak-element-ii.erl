-module(find_peak_ii).
-export([find_peak_grid/1]).

find_peak_grid(Mat) ->
    find_peak_grid(Mat, 0, length(Mat) - 1).

find_peak_grid(Mat, Start, End) ->
    Mid = (Start + End) div 2,
    MaxCol = find_max_col(Mat, Mid),
    if
        Mid > 0 andalso element(element(Mid, Mat), MaxCol) < element(element(Mid - 1, Mat), MaxCol) ->
            find_peak_grid(Mat, Start, Mid - 1);
        Mid < length(Mat) - 1 andalso element(element(Mid, Mat), MaxCol) < element(element(Mid + 1, Mat), MaxCol) ->
            find_peak_grid(Mat, Mid + 1, End);
        true ->
            [Mid, MaxCol - 1]
    end.

find_max_col(Mat, Row) ->
    find_max_col(element(Row, Mat), 1, length(element(Row, Mat)), 1, element(element(Row, Mat), 1)).

find_max_col(_Row, Col, Length, MaxCol, MaxVal) when Col > Length ->
    MaxCol;
find_max_col(Row, Col, Length, MaxCol, MaxVal) ->
    Val = element(Col, Row),
    if
        Val > MaxVal ->
            find_max_col(Row, Col + 1, Length, Col, Val);
        true ->
            find_max_col(Row, Col + 1, Length, MaxCol, MaxVal)
    end.