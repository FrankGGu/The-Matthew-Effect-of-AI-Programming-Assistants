-module(solution).
-export([count_submatrices/3]).

count_submatrices(Matrix, X, Y) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    count_submatrices_helper(Matrix, X, Y, Rows, Cols, 0).

count_submatrices_helper(Matrix, X, Y, Rows, Cols, Count) ->
    lists:foldl(fun(R1, Acc) ->
        lists:foldl(fun(C1, Acc2) ->
            Count = count_equal_frequency(Matrix, R1, C1, X, Y, Rows, Cols),
            Acc2 + Count
        end, Acc, lists:seq(1, Cols))
    end, Count, lists:seq(1, Rows).

count_equal_frequency(Matrix, R1, C1, X, Y, Rows, Cols) ->
    lists:foldl(fun({R2, Acc}) ->
        NewCount = case count_elements(Matrix, R1, C1, R2, Rows, Cols, X, Y) of
            {CountX, CountY} when CountX =:= CountY -> 1;
            _ -> 0
        end,
        Acc + NewCount
    end, 0, lists:seq(R1, Rows)).

count_elements(Matrix, R1, C1, R2, Rows, Cols, X, Y) ->
    lists:foldl(fun(C2, {CountX, CountY}) ->
        case lists:nth(R2, lists:nth(C2, Matrix)) of
            X -> {CountX + 1, CountY};
            Y -> {CountX, CountY + 1};
            _ -> {CountX, CountY}
        end
    end, {0, 0}, lists:seq(C1, Cols).