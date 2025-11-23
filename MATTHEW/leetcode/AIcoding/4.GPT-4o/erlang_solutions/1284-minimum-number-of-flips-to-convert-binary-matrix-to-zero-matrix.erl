-module(solution).
-export([min_flips/1]).

min_flips(Matrix) ->
    {N, M} = lists:foldl(fun(Row, {N, M}) -> {N + 1, length(Row)} end, {0, 0}, Matrix),
    min_flips_helper(Matrix, N, M, 0).

min_flips_helper(Matrix, N, M, Flips) ->
    case is_zero_matrix(Matrix, N, M) of
        true -> Flips;
        false -> 
            [NewRow, NewCol] = find_first_one(Matrix, N, M),
            NewMatrix = flip(Matrix, NewRow, NewCol, N, M),
            min_flips_helper(NewMatrix, N, M, Flips + 1)
    end.

is_zero_matrix(Matrix, N, M) ->
    lists:all(fun(Row) -> lists:all(fun(X) -> X == 0 end, Row) end, Matrix).

find_first_one(Matrix, N, M) ->
    lists:foldl(fun(Row, {R, C}) ->
        case lists:prefix(Row, [1]) of
            true -> {R, lists:find(fun(X) -> X == 1 end, Row) + 1};
            false -> {R + 1, C}
        end
    end, {1, 1}, Matrix).

flip(Matrix, Row, Col, N, M) ->
    NewMatrix = flip_cell(Matrix, Row, Col),
    lists:map(fun(RowIndex) -> flip_row(NewMatrix, RowIndex, Col, M) end, lists:seq(1, N)).

flip_cell(Matrix, Row, Col) ->
    lists:map(fun({Index, RowData}) ->
        if 
            Index == Row -> flip_element(RowData, Col);
            true -> RowData
        end
    end, lists:zip(lists:seq(1, length(Matrix)), Matrix)).

flip_element(Row, Col) ->
    NewRow = lists:map(fun({Index, Value}) ->
        if 
            Index == Col -> 1 - Value;
            true -> Value
        end
    end, lists:zip(lists:seq(1, length(Row)), Row)),
    NewRow.

flip_row(Matrix, RowIndex, Col, M) ->
    lists:map(fun({Index, Value}) ->
        if 
            Index == RowIndex -> flip_element(Value, Col);
            true -> Value
        end
    end, lists:zip(lists:seq(1, M), Matrix)).