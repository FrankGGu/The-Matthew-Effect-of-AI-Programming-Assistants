-spec transpose(Matrix :: [[integer()]]) -> [[integer()]].
transpose(Matrix) ->
    case Matrix of
        [] -> [];
        _ ->
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            [[lists:nth(C, lists:nth(R, Matrix)) || R <- lists:seq(1, Rows)] || C <- lists:seq(1, Cols)]
    end.