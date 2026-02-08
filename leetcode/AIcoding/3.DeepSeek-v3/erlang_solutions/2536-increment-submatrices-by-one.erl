-spec range_add_queries(N :: integer(), Queries :: [[integer()]]) -> [[integer()]].
range_add_queries(N, Queries) ->
    Matrix = lists:duplicate(N, lists:duplicate(N, 0)),
    lists:foldl(fun([Row1, Col1, Row2, Col2], Acc) ->
        update_matrix(Acc, Row1, Col1, Row2, Col2)
    end, Matrix, Queries).

update_matrix(Matrix, Row1, Col1, Row2, Col2) ->
    lists:map(fun(RowIdx) ->
        lists:map(fun(ColIdx) ->
            case (RowIdx >= Row1 andalso RowIdx =< Row2) andalso
                 (ColIdx >= Col1 andalso ColIdx =< Col2) of
                true -> lists:nth(ColIdx + 1, lists:nth(RowIdx + 1, Matrix)) + 1;
                false -> lists:nth(ColIdx + 1, lists:nth(RowIdx + 1, Matrix))
            end
        end, lists:seq(0, length(Matrix) - 1))
    end, lists:seq(0, length(Matrix) - 1)).