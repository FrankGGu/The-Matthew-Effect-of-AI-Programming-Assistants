-spec min_operations(Matrix :: [[integer()]]) -> integer().
min_operations(Matrix) ->
    case Matrix of
        [] -> 0;
        _ ->
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            if
                Rows =:= 1 -> 0;
                true ->
                    lists:sum(
                        lists:map(
                            fun(Col) ->
                                lists:sum(
                                    lists:map(
                                        fun(Row) ->
                                            case Row of
                                                1 when Col < Cols ->
                                                    case lists:nth(Col + 1, lists:nth(Row, Matrix)) < lists:nth(Col, lists:nth(Row, Matrix)) of
                                                        true -> 1;
                                                        false -> 0
                                                    end;
                                                _ -> 0
                                            end
                                        end,
                                        lists:seq(1, Rows)
                                    )
                                )
                            end,
                            lists:seq(1, Cols - 1)
                        )
                    )
            end
    end.