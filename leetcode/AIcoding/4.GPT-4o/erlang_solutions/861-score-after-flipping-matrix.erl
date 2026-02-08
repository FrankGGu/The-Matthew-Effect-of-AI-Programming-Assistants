-module(solution).
-export([matrixScore/1]).

matrixScore(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    FlippedMatrix = [flip_row(Row) || Row <- Matrix],
    ColScores = lists:map(fun(Index) -> column_score(FlippedMatrix, Index) end, lists:seq(0, Cols - 1)),
    TotalScore = lists:sum(ColScores) * (1 bsl (Cols - 1)),
    TotalScore.

flip_row(Row) ->
    case hd(Row) of
        0 -> lists:map(fun(X) -> if X == 0 -> 1; true -> 0 end end, Row);
        _ -> Row
    end.

column_score(Matrix, ColIndex) ->
    CountOnes = lists:sum([Row[ColIndex] || Row <- Matrix]),
    max(CountOnes, length(Matrix) - CountOnes).