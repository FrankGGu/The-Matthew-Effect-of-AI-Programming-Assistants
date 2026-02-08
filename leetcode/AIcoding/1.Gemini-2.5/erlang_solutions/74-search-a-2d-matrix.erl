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
                    search_binary(Matrix, Target, N, 0, M * N - 1)
            end
    end.

search_binary(Matrix, Target, N, Low, High) ->
    if
        Low > High -> false;
        true ->
            Mid = Low + (High - Low) div 2,
            RowIdx = Mid div N,
            ColIdx = Mid rem N,

            CurrentRow = lists:nth(RowIdx + 1, Matrix),
            Value = lists:nth(ColIdx + 1, CurrentRow),

            if
                Value == Target -> true;
                Value < Target -> search_binary(Matrix, Target, N, Mid + 1, High);
                Value > Target -> search_binary(Matrix, Target, N, Low, Mid - 1)
            end
    end.