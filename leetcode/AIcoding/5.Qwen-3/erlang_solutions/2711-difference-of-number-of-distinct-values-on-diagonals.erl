-module(difference_of_number_of_distinct_values_on_diagonals).
-export([equalPairs/1]).

equalPairs(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Map = maps:new(),
    Count = 0,
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            A = lists:nth(I+1, Matrix),
            B = lists:nth(J+1, Matrix),
            Diag1 = getDiagonal(Matrix, I, J),
            Diag2 = getDiagonal(Matrix, J, I),
            Set1 = sets:from_list(Diag1),
            Set2 = sets:from_list(Diag2),
            if
                sets:size(Set1) == sets:size(Set2) ->
                    Acc2 + 1;
                true ->
                    Acc2
            end
        end, Acc, lists:seq(0, Cols-1))
    end, 0, lists:seq(0, Rows-1)).

getDiagonal(Matrix, I, J) ->
    getDiagonalHelper(Matrix, I, J, []).

getDiagonalHelper(_, _, _, Acc) when I < 0 orelse J < 0 -> Acc;
getDiagonalHelper(Matrix, I, J, Acc) ->
    Row = lists:nth(I+1, Matrix),
    Val = lists:nth(J+1, Row),
    getDiagonalHelper(Matrix, I-1, J+1, [Val | Acc]).