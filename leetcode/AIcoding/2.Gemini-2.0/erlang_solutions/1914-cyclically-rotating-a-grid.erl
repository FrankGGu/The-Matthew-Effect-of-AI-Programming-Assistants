-module(cyclically_rotating_grid).
-export([rotateGrid/2]).

rotateGrid(Grid, K) ->
    {Rows, Cols} = grid_size(Grid),
    Levels = min(Rows div 2, Cols div 2),
    rotate_levels(Grid, Levels, K, Rows, Cols).

rotate_levels(Grid, 0, _, _, _) ->
    Grid;
rotate_levels(Grid, Levels, K, Rows, Cols) ->
    Level = Levels - 1,
    Boundary = get_boundary(Grid, Level, Rows, Cols),
    Len = length(Boundary),
    RotatedBoundary = rotate_list(Boundary, K rem Len),
    UpdatedGrid = update_grid(Grid, Level, RotatedBoundary, Rows, Cols),
    rotate_levels(UpdatedGrid, Levels - 1, K, Rows, Cols).

get_boundary(Grid, Level, Rows, Cols) ->
    get_boundary_helper(Grid, Level, Rows, Cols, [], Level, Level).

get_boundary_helper(Grid, Level, Rows, Cols, Acc, Row, Col) when Col < Cols - Level - 1 ->
    get_boundary_helper(Grid, Level, Rows, Cols, Acc ++ [lists:nth(Row + 1, lists:nth(Col + 1, Grid))], Row, Col + 1);
get_boundary_helper(Grid, Level, Rows, Cols, Acc, Row, Col) when Row < Rows - Level - 1 ->
    get_boundary_helper(Grid, Level, Rows, Cols, Acc ++ [lists:nth(Row + 1, lists:nth(Col + 1, Grid))], Row + 1, Col);
get_boundary_helper(Grid, Level, Rows, Cols, Acc, Row, Col) when Col > Level ->
    get_boundary_helper(Grid, Level, Rows, Cols, Acc ++ [lists:nth(Row + 1, lists:nth(Col + 1, Grid))], Row, Col - 1);
get_boundary_helper(Grid, Level, Rows, Cols, Acc, Row, Col) when Row > Level ->
    get_boundary_helper(Grid, Level, Rows, Cols, Acc ++ [lists:nth(Row + 1, lists:nth(Col + 1, Grid))], Row - 1, Col);
get_boundary_helper(Grid, Level, Rows, Cols, Acc, Row, Col) ->
    Acc ++ [lists:nth(Row + 1, lists:nth(Col + 1, Grid))].

update_grid(Grid, Level, RotatedBoundary, Rows, Cols) ->
    update_grid_helper(Grid, Level, RotatedBoundary, Rows, Cols, 0, Level, Level).

update_grid_helper(Grid, Level, [], _, _, _, _, _) ->
    Grid;
update_grid_helper(Grid, Level, [H|T], Rows, Cols, Count, Row, Col) when Col < Cols - Level - 1 ->
    NewGrid = set_grid_value(Grid, Row, Col, H),
    update_grid_helper(NewGrid, Level, T, Rows, Cols, Count + 1, Row, Col + 1);
update_grid_helper(Grid, Level, [H|T], Rows, Cols, Count, Row, Col) when Row < Rows - Level - 1 ->
    NewGrid = set_grid_value(Grid, Row, Col, H),
    update_grid_helper(NewGrid, Level, T, Rows, Cols, Count + 1, Row + 1, Col);
update_grid_helper(Grid, Level, [H|T], Rows, Cols, Count, Row, Col) when Col > Level ->
    NewGrid = set_grid_value(Grid, Row, Col, H),
    update_grid_helper(NewGrid, Level, T, Rows, Cols, Count + 1, Row, Col - 1);
update_grid_helper(Grid, Level, [H|T], Rows, Cols, Count, Row, Col) when Row > Level ->
    NewGrid = set_grid_value(Grid, Row, Col, H),
    update_grid_helper(NewGrid, Level, T, Rows, Cols, Count + 1, Row - 1, Col);
update_grid_helper(Grid, Level, [H|T], Rows, Cols, Count, Row, Col) ->
    NewGrid = set_grid_value(Grid, Row, Col, H),
    update_grid_helper(NewGrid, Level, T, Rows, Cols, Count + 1, Row, Col).

set_grid_value(Grid, Row, Col, Value) ->
    lists:update(Row + 1, lists:update(Col + 1, Value, lists:nth(Row + 1, Grid)), Grid).

rotate_list(List, K) ->
    lists:sublist(lists:nthtail(K, List) ++ lists:sublist(List, K), length(List)).

grid_size(Grid) ->
    {length(Grid), length(lists:nth(1, Grid))}.