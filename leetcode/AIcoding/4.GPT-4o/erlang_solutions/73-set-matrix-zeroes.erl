%% -record(matrix, {data = [[]]}).

-spec set_zeroes(Matrix :: #matrix{}) -> #matrix{}.
set_zeroes(Matrix) ->
    Data = Matrix#matrix.data,
    Rows = length(Data),
    Cols = length(hd(Data)),
    set_zeroes(Data, Rows, Cols, 0, 0).

-spec set_zeroes([[integer()]], integer(), integer(), integer(), integer()) -> [[integer()]].
set_zeroes(Data, Rows, Cols, Row, Col) when Row < Rows ->
    set_zeroes(Data, Rows, Cols, Row, Col + 1);
set_zeroes(Data, Rows, Cols, Row, Col) when Row < Rows andalso Col == Cols ->
    set_zeroes(Data, Rows, Cols, Row + 1, 0);
set_zeroes(Data, Rows, Cols, Row, Col) ->
    case lists:nth(Col + 1, lists:nth(Row + 1, Data)) of
        0 -> 
            set_zeroes(ZeroRow(Data, Row, Col, Rows, Cols), Rows, Cols, Row, Col + 1);
        _ -> set_zeroes(Data, Rows, Cols, Row, Col + 1)
    end.

-spec ZeroRow([[integer()]], integer(), integer(), integer(), integer()) -> [[integer()]].
ZeroRow(Data, Row, Col, Rows, Cols) ->
    lists:map(fun(RowList, Index) -> 
        if 
            Index == Row -> lists:duplicate(Cols, 0); 
            true -> RowList
        end
    end, Data).
