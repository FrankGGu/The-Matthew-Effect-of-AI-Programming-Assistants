-spec projection_area(Grid :: [[integer()]]) -> integer().
projection_area(Grid) ->
    XY = lists:sum([lists:sum([case V > 0 of true -> 1; false -> 0 end || V <- Row]) || Row <- Grid]),
    YZ = lists:sum([lists:max(Row) || Row <- Grid]),
    XZ = lists:sum([lists:max([lists:nth(I, Row) || Row <- Grid]) || I <- lists:seq(1, length(hd(Grid)))]),
    XY + YZ + XZ.