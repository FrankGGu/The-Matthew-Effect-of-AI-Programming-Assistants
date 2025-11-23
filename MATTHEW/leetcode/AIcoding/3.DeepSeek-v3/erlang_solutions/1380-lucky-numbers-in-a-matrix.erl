-spec lucky_numbers(Matrix :: [[integer()]]) -> [integer()].
lucky_numbers(Matrix) ->
    Rows = length(Matrix),
    Cols = case Rows of
               0 -> 0;
               _ -> length(hd(Matrix))
           end,
    RowMins = lists:map(fun(Row) -> lists:min(Row) end, Matrix),
    ColMaxs = lists:map(fun(I) ->
                            Col = lists:map(fun(Row) -> lists:nth(I, Row) end, Matrix),
                            lists:max(Col)
                        end, lists:seq(1, Cols)),
    lists:filter(fun(X) -> lists:member(X, RowMins) andalso lists:member(X, ColMaxs) end, RowMins).