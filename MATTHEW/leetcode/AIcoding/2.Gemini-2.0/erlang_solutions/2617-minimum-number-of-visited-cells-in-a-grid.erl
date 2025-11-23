-module(minimum_number_of_visited_cells_in_a_grid).
-export([minimum_visited_cells/1]).

minimum_visited_cells(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    minimum_visited_cells_helper(Grid, Rows, Cols).

minimum_visited_cells_helper(Grid, Rows, Cols) ->
    Distances = array:new([Rows, Cols], {fixed, infinity}),
    array:set({0, 0}, 0, Distances),

    Q = queue:new(),
    Q1 = queue:in({0, 0}, Q),

    minimum_visited_cells_bfs(Grid, Rows, Cols, Distances, Q1).

minimum_visited_cells_bfs(Grid, Rows, Cols, Distances, Q) ->
    case queue:is_empty(Q) of
        true ->
            case array:get({Rows - 1, Cols - 1}, Distances) of
                infinity -> -1;
                Dist -> Dist + 1
            end;
        false ->
            {Val, Q1} = queue:out(Q),
            {Row, Col} = Val,
            Dist = array:get({Row, Col}, Distances),

            MaxJump = lists:nth(Col + 1, lists:nth(Row + 1, Grid)),

            % Explore right
            Q2 = explore_right(Grid, Rows, Cols, Distances, Q1, Row, Col, MaxJump, Dist),

            % Explore down
            Q3 = explore_down(Grid, Rows, Cols, Distances, Q2, Row, Col, MaxJump, Dist),

            minimum_visited_cells_bfs(Grid, Rows, Cols, Distances, Q3)
    end.

explore_right(Grid, Rows, Cols, Distances, Q, Row, Col, MaxJump, Dist) ->
    explore_right_helper(Grid, Rows, Cols, Distances, Q, Row, Col, MaxJump, Dist, Col+1).

explore_right_helper(Grid, Rows, Cols, Distances, Q, Row, Col, MaxJump, Dist, NextCol) ->
    case NextCol < Cols andalso NextCol =< Col + MaxJump of
        true ->
            NextDist = array:get({Row, NextCol}, Distances);
            case NextDist == infinity of
                true ->
                    array:set({Row, NextCol}, Dist + 1, Distances),
                    Q1 = queue:in({Row, NextCol}, Q),
                    explore_right_helper(Grid, Rows, Cols, Distances, Q1, Row, Col, MaxJump, Dist, NextCol + 1);
                false ->
                    explore_right_helper(Grid, Rows, Cols, Distances, Q, Row, Col, MaxJump, Dist, NextCol + 1)
            end;
        false -> Q
    end.

explore_down(Grid, Rows, Cols, Distances, Q, Row, Col, MaxJump, Dist) ->
    explore_down_helper(Grid, Rows, Cols, Distances, Q, Row, Col, MaxJump, Dist, Row+1).

explore_down_helper(Grid, Rows, Cols, Distances, Q, Row, Col, MaxJump, Dist, NextRow) ->
    case NextRow < Rows andalso NextRow =< Row + MaxJump of
        true ->
            NextDist = array:get({NextRow, Col}, Distances);
            case NextDist == infinity of
                true ->
                    array:set({NextRow, Col}, Dist + 1, Distances),
                    Q1 = queue:in({NextRow, Col}, Q),
                    explore_down_helper(Grid, Rows, Cols, Distances, Q1, Row, Col, MaxJump, Dist, NextRow + 1);
                false ->
                    explore_down_helper(Grid, Rows, Cols, Distances, Q, Row, Col, MaxJump, Dist, NextRow + 1)
            end;
        false -> Q
    end.