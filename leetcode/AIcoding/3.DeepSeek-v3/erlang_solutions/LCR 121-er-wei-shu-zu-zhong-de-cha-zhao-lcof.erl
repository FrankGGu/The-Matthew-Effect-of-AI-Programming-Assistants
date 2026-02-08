-spec search_matrix(Matrix :: [[integer()]], Target :: integer()) -> boolean().
search_matrix(Matrix, Target) ->
    case Matrix of
        [] -> false;
        _ ->
            Rows = length(Matrix),
            Cols = length(hd(Matrix))),
            search(Matrix, Target, 0, Rows - 1, 0, Cols - 1)
    end.

search(Matrix, Target, RowStart, RowEnd, ColStart, ColEnd) ->
    if
        RowStart > RowEnd orelse ColStart > ColEnd -> false;
        true ->
            RowMid = (RowStart + RowEnd) div 2,
            ColMid = (ColStart + ColEnd) div 2,
            Value = lists:nth(ColMid + 1, lists:nth(RowMid + 1, Matrix)),
            if
                Value =:= Target -> true;
                Value < Target ->
                    search(Matrix, Target, RowMid + 1, RowEnd, ColStart, ColEnd) orelse
                    search(Matrix, Target, RowStart, RowMid, ColMid + 1, ColEnd);
                true ->
                    search(Matrix, Target, RowStart, RowMid - 1, ColStart, ColEnd) orelse
                    search(Matrix, Target, RowMid, RowEnd, ColStart, ColMid - 1)
            end
    end.