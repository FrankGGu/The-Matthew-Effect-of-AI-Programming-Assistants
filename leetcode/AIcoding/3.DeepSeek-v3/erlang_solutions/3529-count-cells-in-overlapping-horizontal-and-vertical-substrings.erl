-spec count_cells(Horizontal :: [unicode:unicode_binary()], Vertical :: [unicode:unicode_binary()]) -> integer().
count_cells(Horizontal, Vertical) ->
    Rows = length(Horizontal),
    Cols = length(Vertical),
    Grid = lists:duplicate(Rows, lists:duplicate(Cols, false)),

    Grid1 = mark_horizontal(Horizontal, Grid, 0),
    Grid2 = mark_vertical(Vertical, Grid1, 0),

    count_marked(Grid2).

mark_horizontal([], Grid, _) -> Grid;
mark_horizontal([H|T], Grid, Row) ->
    NewGrid = mark_row(H, Grid, Row, 0),
    mark_horizontal(T, NewGrid, Row + 1).

mark_row(<<>>, Grid, _, _) -> Grid;
mark_row(<<"1", Rest/binary>>, Grid, Row, Col) ->
    NewRow = lists:nth(Row + 1, Grid),
    UpdatedRow = setelement(Col + 1, list_to_tuple(NewRow), true),
    NewGrid = setelement(Row + 1, list_to_tuple(Grid), tuple_to_list(UpdatedRow)),
    mark_row(Rest, tuple_to_list(NewGrid), Row, Col + 1);
mark_row(<<_, Rest/binary>>, Grid, Row, Col) ->
    mark_row(Rest, Grid, Row, Col + 1).

mark_vertical([], Grid, _) -> Grid;
mark_vertical([V|T], Grid, Col) ->
    NewGrid = mark_col(V, Grid, 0, Col),
    mark_vertical(T, NewGrid, Col + 1).

mark_col(<<>>, Grid, _, _) -> Grid;
mark_col(<<"1", Rest/binary>>, Grid, Row, Col) ->
    RowList = lists:nth(Row + 1, Grid),
    UpdatedRow = setelement(Col + 1, list_to_tuple(RowList), true),
    NewGrid = setelement(Row + 1, list_to_tuple(Grid), tuple_to_list(UpdatedRow)),
    mark_col(Rest, tuple_to_list(NewGrid), Row + 1, Col);
mark_col(<<_, Rest/binary>>, Grid, Row, Col) ->
    mark_col(Rest, Grid, Row + 1, Col).

count_marked(Grid) ->
    lists:sum([lists:sum([case Cell of true -> 1; false -> 0 end || Cell <- Row]) || Row <- Grid]).