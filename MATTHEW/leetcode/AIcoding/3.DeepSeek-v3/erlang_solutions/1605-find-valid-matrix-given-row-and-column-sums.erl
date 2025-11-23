-spec restore_matrix(RowSum :: [integer()], ColSum :: [integer()]) -> [[integer()]].
restore_matrix(RowSum, ColSum) ->
    M = length(RowSum),
    N = length(ColSum),
    Matrix = lists:duplicate(M, lists:duplicate(N, 0)),
    restore_matrix(RowSum, ColSum, Matrix, 0, 0).

restore_matrix([], _, Matrix, _, _) -> Matrix;
restore_matrix(_, [], Matrix, _, _) -> Matrix;
restore_matrix([R | Rs], [C | Cs], Matrix, I, J) ->
    Val = min(R, C),
    NewMatrix = set_matrix(Matrix, I, J, Val),
    NewR = R - Val,
    NewC = C - Val,
    if
        NewR == 0 ->
            restore_matrix(Rs, [NewC | Cs], NewMatrix, I + 1, J);
        true ->
            restore_matrix([NewR | Rs], Cs, NewMatrix, I, J + 1)
    end.

set_matrix(Matrix, I, J, Val) ->
    Row = lists:nth(I + 1, Matrix),
    NewRow = set_list(Row, J, Val),
    set_list(Matrix, I, NewRow).

set_list(List, Index, Value) ->
    {Prefix, [_ | Suffix]} = lists:split(Index, List),
    Prefix ++ [Value | Suffix].