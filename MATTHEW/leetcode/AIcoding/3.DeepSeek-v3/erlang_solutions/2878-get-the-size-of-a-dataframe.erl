-spec size(DataFrame :: term()) -> [integer()].
size(DataFrame) ->
    case DataFrame of
        #{rows := Rows, columns := Cols} -> [length(Rows), length(Cols)];
        _ -> [0, 0]
    end.