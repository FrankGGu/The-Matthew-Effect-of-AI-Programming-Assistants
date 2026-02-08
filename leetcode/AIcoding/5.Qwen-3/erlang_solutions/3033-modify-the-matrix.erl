-module(modify_matrix).
-export([modify_matrix/1]).

modify_matrix(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    NewMatrix = lists:map(fun(Row) -> lists:map(fun(_) -> 0 end, Row) end, Matrix),
    modify_matrix(Matrix, NewMatrix, 0, 0, Rows, Cols).

modify_matrix(_, _, R, C, R, _) ->
    NewMatrix;
modify_matrix(Matrix, NewMatrix, R, C, Rows, Cols) ->
    Value = lists:nth(R+1, Matrix),
    Cell = lists:nth(C+1, Value),
    if
        Cell == 0 ->
            modify_matrix(Matrix, NewMatrix, R, C+1, Rows, Cols);
        true ->
            NewRow = lists:sublist(NewMatrix, R) ++ 
                     [lists:sublist(lists:nth(R+1, NewMatrix), C) ++ [Cell] ++ lists:nthtail(C+1, lists:nth(R+1, NewMatrix))] ++
                     lists:sublist(NewMatrix, R+1, Rows - R - 1),
            modify_matrix(Matrix, NewRow, R, C+1, Rows, Cols)
    end.