-module(kth_nearest_obstacle_queries).
-export([kth_nearest_obstacle_queries/3]).

kth_nearest_obstacle_queries(Grid, Queries, K) ->
    {Rows, Cols} = grid_size(Grid),
    Obstacles = find_obstacles(Grid, Rows, Cols),
    lists:map(fun(Query) -> find_kth_nearest(Query, Obstacles, K, Rows, Cols) end, Queries).

grid_size(Grid) ->
    {length(Grid), length(hd(Grid))}.

find_obstacles(Grid, Rows, Cols) ->
    find_obstacles_helper(Grid, Rows, Cols, 0, 0, []).

find_obstacles_helper(_Grid, Rows, _Cols, Row, _Col, Acc) when Row >= Rows ->
    Acc;
find_obstacles_helper(Grid, Rows, Cols, Row, Col, Acc) when Col >= Cols ->
    find_obstacles_helper(Grid, Rows, Cols, Row + 1, 0, Acc);
find_obstacles_helper(Grid, Rows, Cols, Row, Col, Acc) ->
    case lists:nth(Row + 1, Grid) of
        RowList ->
            case lists:nth(Col + 1, RowList) of
                1 ->
                    find_obstacles_helper(Grid, Rows, Cols, Row, Col + 1, [{Row, Col} | Acc]);
                _ ->
                    find_obstacles_helper(Grid, Rows, Cols, Row, Col + 1, Acc)
            end
    end.

find_kth_nearest({Row, Col}, Obstacles, K, Rows, Cols) ->
    SortedObstacles = lists:sort(fun({R1, C1}, {R2, C2}) ->
                                         abs(R1 - Row) + abs(C1 - Col) < abs(R2 - Row) + abs(C2 - Col)
                                 end, Obstacles),
    case length(SortedObstacles) < K of
        true -> -1;
        false ->
            {KthRow, KthCol} = lists:nth(K, SortedObstacles),
            KthRow * Cols + KthCol
    end.