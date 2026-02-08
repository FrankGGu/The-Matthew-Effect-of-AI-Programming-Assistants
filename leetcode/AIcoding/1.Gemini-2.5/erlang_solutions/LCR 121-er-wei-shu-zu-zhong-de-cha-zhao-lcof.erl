-module(solution).
-export([searchMatrix/2]).

searchMatrix(Matrix, Target) ->
    M = length(Matrix),
    case M of
        0 -> false;
        _ ->
            N = length(hd(Matrix)),
            case N of
                0 -> false;
                _ ->
                    search(0, N - 1, Matrix, Target, M, N)
            end
    end.

search(Row, Col, Matrix, Target, M, N) when Row >= M; Col < 0 ->
    false;
search(Row, Col, Matrix, Target, M, N) ->
    CurrentRow = lists:nth(Row + 1, Matrix),
    CurrentVal = lists:nth(Col + 1, CurrentRow),

    if
        CurrentVal == Target ->
            true;
        CurrentVal < Target ->
            search(Row + 1, Col, Matrix, Target, M, N);
        true -> %% CurrentVal > Target
            search(Row, Col - 1, Matrix, Target, M, N)
    end.