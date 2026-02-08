-spec search_matrix(Matrix :: [[integer()]], Target :: integer()) -> boolean().
search_matrix(Matrix, Target) ->
    case Matrix of
        [] -> false;
        _ ->
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            binary_search(Matrix, Target, 0, Rows * Cols - 1, Cols)
    end.

binary_search(_, _, Low, High, _) when Low > High -> false;
binary_search(Matrix, Target, Low, High, Cols) ->
    Mid = (Low + High) div 2,
    Row = Mid div Cols,
    Col = Mid rem Cols,
    Value = lists:nth(Col + 1, lists:nth(Row + 1, Matrix)),
    if
        Value =:= Target -> true;
        Value < Target -> binary_search(Matrix, Target, Mid + 1, High, Cols);
        true -> binary_search(Matrix, Target, Low, Mid - 1, Cols)
    end.