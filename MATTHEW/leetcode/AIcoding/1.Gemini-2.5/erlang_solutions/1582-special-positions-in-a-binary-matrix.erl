-module(solution).
-export([specialPositions/1]).

transpose([]) -> [];
transpose([[]|_]) -> [];
transpose(Matrix) ->
    [ [H || [H|_] <- Matrix] | transpose([T || [_|T] <- Matrix]) ].

row_sums(Matrix) ->
    [lists:sum(Row) || Row <- Matrix].

specialPositions(Mat) ->
    M = length(Mat),
    case M of
        0 -> 0;
        _ ->
            N = length(hd(Mat)),
            case N of
                0 -> 0;
                _ ->
                    RowSums = row_sums(Mat),
                    ColSums = row_sums(transpose(Mat)),
                    count_special(Mat, RowSums, ColSums, 0, 0, 0, M, N)
            end
    end.

count_special(_Mat, _RowSums, _ColSums, R, _C, Count, M, _N) when R == M ->
    Count;
count_special(Mat, RowSums, ColSums, R, C, Count, M, N) when C == N ->
    count_special(Mat, RowSums, ColSums, R + 1, 0, Count, M, N);
count_special(Mat, RowSums, ColSums, R, C, Count, M, N) ->
    CurrentRow = lists:nth(R + 1, Mat),
    Val = lists:nth(C + 1, CurrentRow),

    case Val of
        1 ->
            RowSum = lists:nth(R + 1, RowSums),
            ColSum = lists:nth(C + 1, ColSums),
            case {RowSum, ColSum} of
                {1, 1} ->
                    count_special(Mat, RowSums, ColSums, R, C + 1, Count + 1, M, N);
                _ ->
                    count_special(Mat, RowSums, ColSums, R, C + 1, Count, M, N)
            end;
        0 ->
            count_special(Mat, RowSums, ColSums, R, C + 1, Count, M, N)
    end.