-module(image_smoother).
-export([imageSmoother/1]).

imageSmoother(Image) ->
    Rows = length(Image),
    Cols = length(hd(Image)),
    lists:foldl(fun(RowIndex, Acc) ->
        lists:foldl(fun(ColIndex, Acc2) ->
            Sum = sumNeighbors(Image, RowIndex, ColIndex, Rows, Cols),
            Count = countNeighbors(RowIndex, ColIndex, Rows, Cols),
            lists:append(Acc2, [[Sum div Count]])
        end, Acc, lists:seq(0, Cols - 1))
    end, [], lists:seq(0, Rows - 1)).

sumNeighbors(_, _, _, 0, _) -> 0;
sumNeighbors(_, _, _, _, 0) -> 0;
sumNeighbors(Image, Row, Col, Rows, Cols) ->
    lists:sum([
        neighborValue(Image, Row - 1, Col - 1, Rows, Cols),
        neighborValue(Image, Row - 1, Col, Rows, Cols),
        neighborValue(Image, Row - 1, Col + 1, Rows, Cols),
        neighborValue(Image, Row, Col - 1, Rows, Cols),
        neighborValue(Image, Row, Col, Rows, Cols),
        neighborValue(Image, Row, Col + 1, Rows, Cols),
        neighborValue(Image, Row + 1, Col - 1, Rows, Cols),
        neighborValue(Image, Row + 1, Col, Rows, Cols),
        neighborValue(Image, Row + 1, Col + 1, Rows, Cols)
    ]).

neighborValue(Image, Row, Col, Rows, Cols) ->
    if
        Row >= 0, Row < Rows, Col >= 0, Col < Cols ->
            lists:nth(Row + 1, Image) ! (Col + 1);
        true ->
            0
    end.

countNeighbors(Row, Col, Rows, Cols) ->
    lists:foldl(fun(RowDelta, Count) ->
        lists:foldl(fun(ColDelta, Count2) ->
            if
                Row + RowDelta >= 0, Row + RowDelta < Rows,
                Col + ColDelta >= 0, Col + ColDelta < Cols ->
                    Count2 + 1;
                true ->
                    Count2
            end
        end, Count, [-1, 0, 1])
    end, 0, [-1, 0, 1]).