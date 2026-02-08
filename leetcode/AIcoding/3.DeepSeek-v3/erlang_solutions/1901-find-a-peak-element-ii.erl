-spec find_peak_grid(Matrix :: [[integer()]]) -> [integer()].
find_peak_grid(Matrix) ->
    M = length(Matrix),
    N = length(hd(Matrix)),
    find_peak(Matrix, 0, M - 1, 0, N - 1).

find_peak(Matrix, RowStart, RowEnd, ColStart, ColEnd) ->
    MidRow = (RowStart + RowEnd) div 2,
    {MaxCol, MaxVal} = find_max_in_row(Matrix, MidRow, ColStart, ColEnd),
    IsPeak = check_peak(Matrix, MidRow, MaxCol, MaxVal),
    if
        IsPeak -> [MidRow, MaxCol];
        MidRow > 0 andalso (lists:nth(MaxCol + 1, lists:nth(MidRow, Matrix)) < lists:nth(MaxCol + 1, lists:nth(MidRow - 1, Matrix))) ->
            find_peak(Matrix, RowStart, MidRow - 1, ColStart, ColEnd);
        true ->
            find_peak(Matrix, MidRow + 1, RowEnd, ColStart, ColEnd)
    end.

find_max_in_row(Matrix, Row, ColStart, ColEnd) ->
    RowList = lists:nth(Row + 1, Matrix),
    find_max_in_row(RowList, ColStart, ColEnd, ColStart, lists:nth(ColStart + 1, RowList)).

find_max_in_row(RowList, ColStart, ColEnd, MaxCol, MaxVal) when ColStart =< ColEnd ->
    CurrentVal = lists:nth(ColStart + 1, RowList),
    if
        CurrentVal > MaxVal -> find_max_in_row(RowList, ColStart + 1, ColEnd, ColStart, CurrentVal);
        true -> find_max_in_row(RowList, ColStart + 1, ColEnd, MaxCol, MaxVal)
    end;
find_max_in_row(_RowList, _ColStart, _ColEnd, MaxCol, MaxVal) ->
    {MaxCol, MaxVal}.

check_peak(Matrix, Row, Col, Val) ->
    M = length(Matrix),
    N = length(hd(Matrix)),
    ((Row =:= 0 orelse lists:nth(Col + 1, lists:nth(Row, Matrix)) < Val) andalso
    ((Row =:= M - 1 orelse lists:nth(Col + 1, lists:nth(Row + 2, Matrix)) < Val) andalso
    ((Col =:= 0 orelse lists:nth(Col, lists:nth(Row + 1, Matrix)) < Val) andalso
    ((Col =:= N - 1 orelse lists:nth(Col + 2, lists:nth(Row + 1, Matrix)) < Val))).