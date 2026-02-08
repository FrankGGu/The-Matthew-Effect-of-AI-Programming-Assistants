-module(max_area_of_island).
-export([max_area_of_island/1]).

max_area_of_island(Grid) ->
    max_area(Grid, 0, 0, 0).

max_area(_, Row, Col, Max) when Row >= length(Grid) ->
    Max;
max_area(Grid, Row, Col, Max) when Col >= length(hd(Grid)) ->
    max_area(Grid, Row + 1, 0, Max);
max_area(Grid, Row, Col, Max) ->
    if
        lists:nth(Row + 1, Grid) -- [Col] == [1] ->
            Area = dfs(Grid, Row, Col),
            max_area(Grid, Row, Col + 1, max(Max, Area));
        true ->
            max_area(Grid, Row, Col + 1, Max)
    end.

dfs(_, Row, Col) when Row < 0 orelse Row >= length(Grid) orelse Col < 0 orelse Col >= length(hd(Grid)) ->
    0;
dfs(Grid, Row, Col) ->
    if
        lists:nth(Row + 1, Grid) -- [Col] == [1] ->
            lists:foldl(fun(_, Acc) -> Acc + dfs(Grid, Row + DR, Col + DC) end, 1, [{-1,0}, {1,0}, {0,-1}, {0,1}]);
        true ->
            0
    end.