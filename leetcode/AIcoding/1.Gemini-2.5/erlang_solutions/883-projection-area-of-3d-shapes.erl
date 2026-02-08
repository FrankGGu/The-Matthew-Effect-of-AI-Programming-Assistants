-module(solution).
-export([projection_area/1]).

-spec projection_area(Grid :: [[integer()]]) -> integer().
projection_area(Grid) ->
    N = length(Grid),
    M = length(hd(Grid)),

    XYArea = lists:sum([lists:sum([if H > 0 -> 1; true -> 0 end || H <- Row]) || Row <- Grid]),

    ZXArea = lists:sum([lists:max(Row) || Row <- Grid]),

    Columns = [
        [lists:nth(J + 1, Row) || Row <- Grid]
        || J <- lists:seq(0, M - 1)
    ],
    YZArea = lists:sum([lists:max(Col) || Col <- Columns]),

    XYArea + ZXArea + YZArea.