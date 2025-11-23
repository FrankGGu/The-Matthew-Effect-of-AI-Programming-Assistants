-module(largest_local_values).
-export([largestLocal/1]).

largestLocal(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    generateResult(Matrix, Rows, Cols).

generateResult(_, 0, _) -> [];
generateResult(Matrix, Row, Cols) ->
    [generateRow(Matrix, Row, Cols) | generateResult(Matrix, Row - 1, Cols)].

generateRow(_, _, 0) -> [];
generateRow(Matrix, Row, Col) ->
    Max = findMax(Matrix, Row, Col),
    [Max | generateRow(Matrix, Row, Col - 1)].

findMax(Matrix, Row, Col) ->
    MaxVal = lists:max([
        element(Row, Matrix),
        element(Row + 1, Matrix),
        element(Row - 1, Matrix)
    ]),
    lists:max([
        lists:max(lists:sublist(element(Row, Matrix), Col - 1, 3)),
        lists:max(lists:sublist(element(Row + 1, Matrix), Col - 1, 3)),
        lists:max(lists:sublist(element(Row - 1, Matrix), Col - 1, 3))
    ]).