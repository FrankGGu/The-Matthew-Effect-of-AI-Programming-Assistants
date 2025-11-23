-module(solution).
-export([solve/1]).

solve(Grid) ->
    {Rows, Cols} = grid_size(Grid),
    Walls = find_walls(Grid, Rows, Cols),
    NumGuards = count_guards(Walls, Rows, Cols),
    NumGuards.

grid_size(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    {Rows, Cols}.

find_walls(Grid, Rows, Cols) ->
    find_walls_helper(Grid, Rows, Cols, 0, 0, []).

find_walls_helper(_, Rows, _, Row, _, Walls) when Row >= Rows ->
    Walls;
find_walls_helper(Grid, Rows, Cols, Row, Col, Walls) when Col >= Cols ->
    find_walls_helper(Grid, Rows, Cols, Row + 1, 0, Walls);
find_walls_helper(Grid, Rows, Cols, Row, Col, Walls) ->
    case lists:nth(Row + 1, Grid) of
        RowList ->
            case lists:nth(Col + 1, RowList) of
                1 ->
                    NewWalls = Walls ++ get_adjacent_walls(Row, Col, Rows, Cols);
                    find_walls_helper(Grid, Rows, Cols, Row, Col + 1, NewWalls);
                _ ->
                    find_walls_helper(Grid, Rows, Cols, Row, Col + 1, Walls)
            end
    end.

get_adjacent_walls(Row, Col, Rows, Cols) ->
    Walls = [],
    Walls1 = case Row > 0 of
        true -> [{Row - 1, Col, Row, Col} | Walls];
        false -> Walls
    end,
    Walls2 = case Row < Rows - 1 of
        true -> [{Row + 1, Col, Row, Col} | Walls1];
        false -> Walls1
    end,
    Walls3 = case Col > 0 of
        true -> [{Row, Col - 1, Row, Col} | Walls2];
        false -> Walls2
    end,
    Walls4 = case Col < Cols - 1 of
        true -> [{Row, Col + 1, Row, Col} | Walls3];
        false -> Walls3
    end,
    Walls4.

count_guards(Walls, Rows, Cols) ->
    length(lists:usort(Walls)).