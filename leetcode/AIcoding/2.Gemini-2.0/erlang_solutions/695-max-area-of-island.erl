-module(max_area_of_island).
-export([max_area_island/1]).

max_area_island(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Visited = orddict:new(),
    max_area_island_helper(Grid, Rows, Cols, Visited, 0).

max_area_island_helper(Grid, Rows, Cols, Visited, MaxArea) ->
    case next_unvisited_land(Grid, Rows, Cols, Visited) of
        {Row, Col} ->
            {Area, NewVisited} = area(Grid, Rows, Cols, Row, Col, Visited, 0),
            max_area_island_helper(Grid, Rows, Cols, NewVisited, max(MaxArea, Area));
        none ->
            MaxArea
    end.

area(Grid, Rows, Cols, Row, Col, Visited, Area) ->
    case is_valid(Row, Col, Rows, Cols, Grid, Visited) of
        true ->
            NewVisited = orddict:store({Row, Col}, true, Visited),
            Area1 = area(Grid, Rows, Cols, Row - 1, Col, NewVisited, Area + 1),
            Area2 = area(Grid, Rows, Cols, Row + 1, Col, NewVisited, Area1),
            Area3 = area(Grid, Rows, Cols, Row, Col - 1, NewVisited, Area2),
            Area4 = area(Grid, Rows, Cols, Row, Col + 1, NewVisited, Area3),
            {Area4, NewVisited};
        false ->
            {Area, Visited}
    end.

is_valid(Row, Col, Rows, Cols, Grid, Visited) ->
    Row >= 0 andalso Row < Rows andalso Col >= 0 andalso Col < Cols andalso
    lists:nth(Col + 1, lists:nth(Row + 1, Grid)) == 1 andalso
    not orddict:is_key({Row, Col}, Visited).

next_unvisited_land(Grid, Rows, Cols, Visited) ->
    next_unvisited_land_helper(Grid, Rows, Cols, Visited, 0, 0).

next_unvisited_land_helper(Grid, Rows, Cols, Visited, Row, Col) ->
    case Row < Rows of
        true ->
            case Col < Cols of
                true ->
                    case is_valid(Row, Col, Rows, Cols, Grid, Visited) of
                        true ->
                            {Row, Col};
                        false ->
                            next_unvisited_land_helper(Grid, Rows, Cols, Visited, Row, Col + 1)
                    end;
                false ->
                    next_unvisited_land_helper(Grid, Rows, Cols, Visited, Row + 1, 0)
            end;
        false ->
            none
    end.