-spec maximal_rectangle(Matrix :: [[char()]]) -> integer().
maximal_rectangle(Matrix) ->
    case Matrix of
        [] -> 0;
        _ ->
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            DP = array:new([{size, Rows}, {default, array:new([{size, Cols}, {default, 0}])}]),
            MaxArea = 0,
            {DP1, MaxArea1} = process_matrix(Matrix, DP, MaxArea, 0, Rows, Cols),
            MaxArea1
    end.

process_matrix(_, DP, MaxArea, Row, Rows, _) when Row >= Rows ->
    {DP, MaxArea};
process_matrix(Matrix, DP, MaxArea, Row, Rows, Cols) ->
    {DP1, MaxArea1} = process_row(Matrix, DP, MaxArea, Row, 0, Cols),
    process_matrix(Matrix, DP1, MaxArea1, Row + 1, Rows, Cols).

process_row(_, DP, MaxArea, _, Col, Cols) when Col >= Cols ->
    {DP, MaxArea};
process_row(Matrix, DP, MaxArea, Row, Col, Cols) ->
    case lists:nth(Col + 1, lists:nth(Row + 1, Matrix)) of
        $0 ->
            Array = array:get(Row, DP),
            NewArray = array:set(Col, 0, Array),
            NewDP = array:set(Row, NewArray, DP),
            process_row(Matrix, NewDP, MaxArea, Row, Col + 1, Cols);
        $1 ->
            PrevRow = if Row > 0 -> array:get(Row - 1, DP); true -> array:new([{size, Cols}, {default, 0}]) end,
            PrevVal = array:get(Col, PrevRow),
            Array = array:get(Row, DP),
            NewVal = if Row == 0 -> 1; true -> PrevVal + 1 end,
            NewArray = array:set(Col, NewVal, Array),
            NewDP = array:set(Row, NewArray, DP),
            CurrentHeight = NewVal,
            CurrentMax = calculate_max(NewArray, Col, CurrentHeight, CurrentHeight, 1),
            NewMaxArea = max(MaxArea, CurrentMax),
            process_row(Matrix, NewDP, NewMaxArea, Row, Col + 1, Cols)
    end.

calculate_max(Array, Col, MinHeight, MaxArea, Width) ->
    if
        Col < 0 -> MaxArea;
        true ->
            CurrentHeight = array:get(Col, Array),
            NewMinHeight = min(MinHeight, CurrentHeight),
            NewArea = NewMinHeight * Width,
            NewMaxArea = max(MaxArea, NewArea),
            calculate_max(Array, Col - 1, NewMinHeight, NewMaxArea, Width + 1)
    end.