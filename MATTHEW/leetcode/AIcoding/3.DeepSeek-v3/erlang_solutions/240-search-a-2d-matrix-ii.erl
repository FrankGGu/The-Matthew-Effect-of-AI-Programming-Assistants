-spec search_matrix(Matrix :: [[integer()]], Target :: integer()) -> boolean().
search_matrix(Matrix, Target) ->
    case Matrix of
        [] -> false;
        _ ->
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            search(Matrix, Target, 0, Cols - 1, Rows, Cols)
    end.

search(Matrix, Target, Row, Col, Rows, Cols) ->
    if
        Row >= Rows; Col < 0 -> false;
        true ->
            Current = lists:nth(Row + 1, lists:nth(Col + 1, Matrix)),
            if
                Current =:= Target -> true;
                Current < Target -> search(Matrix, Target, Row + 1, Col, Rows, Cols);
                true -> search(Matrix, Target, Row, Col - 1, Rows, Cols)
            end
    end.