-spec matrix_sum_queries(N :: integer(), Queries :: [[integer()]]) -> integer().
matrix_sum_queries(N, Queries) ->
    Rows = sets:new(),
    Cols = sets:new(),
    Sum = 0,
    process_queries(lists:reverse(Queries), N, Rows, Cols, Sum).

process_queries([], _, _, _, Sum) -> Sum;
process_queries([[Type, Index, Val] | Rest], N, Rows, Cols, Sum) ->
    case Type of
        0 ->
            case sets:is_element(Index, Rows) of
                false ->
                    NewRows = sets:add_element(Index, Rows),
                    Count = N - sets:size(Cols),
                    NewSum = Sum + Val * Count,
                    process_queries(Rest, N, NewRows, Cols, NewSum);
                true ->
                    process_queries(Rest, N, Rows, Cols, Sum)
            end;
        1 ->
            case sets:is_element(Index, Cols) of
                false ->
                    NewCols = sets:add_element(Index, Cols),
                    Count = N - sets:size(Rows),
                    NewSum = Sum + Val * Count,
                    process_queries(Rest, N, Rows, NewCols, NewSum);
                true ->
                    process_queries(Rest, N, Rows, Cols, Sum)
            end
    end.