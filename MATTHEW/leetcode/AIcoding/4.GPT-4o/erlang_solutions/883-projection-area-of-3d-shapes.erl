-module(solution).
-export([projection_area/1]).

projection_area(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    TopArea = Rows * Cols,
    FrontArea = lists:sum([lists:max(Row) || Row <- Grid]),
    SideArea = lists:sum([lists:max(lists:zipwith(fun(X, Y) -> max(X, Y) end, Row, lists:reverse(Grid)) || Row <- Grid)]),
    TopArea + FrontArea + SideArea.