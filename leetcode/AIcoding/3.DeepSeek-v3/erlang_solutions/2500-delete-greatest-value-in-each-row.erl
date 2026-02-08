-spec delete_greatest_value(Grid :: [[integer()]]) -> integer().
delete_greatest_value(Grid) ->
    SortedRows = [lists:sort(Row) || Row <- Grid],
    delete_greatest_value(SortedRows, 0).

delete_greatest_value([[]|_], Sum) -> Sum;
delete_greatest_value(Grid, Sum) ->
    Max = lists:max([hd(Row) || Row <- Grid]),
    NewGrid = [tl(Row) || Row <- Grid],
    delete_greatest_value(NewGrid, Sum + Max).