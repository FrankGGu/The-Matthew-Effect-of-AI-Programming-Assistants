-spec first_complete_index(Arr :: [integer()], Mat :: [[integer()]]) -> integer().
first_complete_index(Arr, Mat) ->
    M = length(Mat),
    N = length(hd(Mat)),
    RowCount = maps:new(),
    ColCount = maps:new(),
    PosMap = maps:from_list([{lists:nth(I, lists:concat(Mat)), {I div N, I rem N}} || I <- lists:seq(0, M * N - 1)]),
    first_complete_index(Arr, RowCount, ColCount, PosMap, M, N, 0).

first_complete_index([H | T], RowCount, ColCount, PosMap, M, N, Index) ->
    {Row, Col} = maps:get(H, PosMap),
    NewRowCount = maps:update_with(Row, fun(V) -> V + 1 end, 1, RowCount),
    NewColCount = maps:update_with(Col, fun(V) -> V + 1 end, 1, ColCount),
    case (maps:get(Row, NewRowCount, 0) =:= N orelse (maps:get(Col, NewColCount, 0) =:= M) of
        true -> Index;
        false -> first_complete_index(T, NewRowCount, NewColCount, PosMap, M, N, Index + 1)
    end.