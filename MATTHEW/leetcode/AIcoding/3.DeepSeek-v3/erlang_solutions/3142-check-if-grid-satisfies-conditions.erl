-spec satisfies_conditions(Grid :: [[integer()]]) -> boolean().
satisfies_conditions(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    lists:all(fun(Row) -> length(Row) == Cols end, Grid),
    CheckRow = fun(Row, NextRow) ->
        lists:all(fun({X, Y}) -> X == Y end, lists:zip(Row, NextRow))
    end,
    CheckCol = fun(Row) ->
        lists:all(fun(X) -> X == hd(Row) end, tl(Row))
    end,
    case Rows > 1 of
        true ->
            lists:all(fun(I) -> CheckRow(lists:nth(I, Grid), lists:nth(I + 1, Grid)) end, lists:seq(1, Rows - 1)) andalso
            lists:all(fun(Row) -> CheckCol(Row) end, Grid);
        false ->
            CheckCol(hd(Grid))
    end.