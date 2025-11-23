-module(minimum_obstacle_removal).
-export([minimum_obstacle_removal/1]).

minimum_obstacle_removal(Grid) ->
    {Rows, Cols} = grid_size(Grid),
    minimum_obstacle_removal(Grid, Rows, Cols).

minimum_obstacle_removal(Grid, Rows, Cols) ->
    Dists = array:new([Rows, Cols], {value, infinity}),
    array:set({0, 0}, Dists, {value, 0}),
    Q = [{0, 0}],
    minimum_obstacle_removal_loop(Grid, Rows, Cols, Dists, Q).

minimum_obstacle_removal_loop(_Grid, _Rows, _Cols, Dists, []) ->
    {value, Result} = array:get({Rows - 1, Cols - 1}, Dists),
    Result;
minimum_obstacle_removal_loop(Grid, Rows, Cols, Dists, [H|T]) ->
    {Row, Col} = H,
    {value, Dist} = array:get({Row, Col}, Dists),
    Neighbors = get_neighbors(Grid, Rows, Cols, Row, Col),
    NewQ = lists:foldl(fun({NewRow, NewCol, Cost}, Acc) ->
                                    {value, OldDist} = array:get({NewRow, NewCol}, Dists),
                                    NewDist = Dist + Cost,
                                    if NewDist < OldDist ->
                                        array:set({NewRow, NewCol}, Dists, {value, NewDist}),
                                        Acc ++ [{NewRow, NewCol}];
                                    true ->
                                        Acc
                                    end
                            end, [], Neighbors),
    minimum_obstacle_removal_loop(Grid, Rows, Cols, Dists, T ++ NewQ).

get_neighbors(Grid, Rows, Cols, Row, Col) ->
    Neighbors = [],
    Neighbors1 = case Row > 0 of
                     true -> [{Row - 1, Col, get_grid_value(Grid, Row - 1, Col)}];
                     false -> []
                 end,
    Neighbors2 = case Row < Rows - 1 of
                     true -> [{Row + 1, Col, get_grid_value(Grid, Row + 1, Col)}];
                     false -> []
                 end,
    Neighbors3 = case Col > 0 of
                     true -> [{Row, Col - 1, get_grid_value(Grid, Row, Col - 1)}];
                     false -> []
                 end,
    Neighbors4 = case Col < Cols - 1 of
                     true -> [{Row, Col + 1, get_grid_value(Grid, Row, Col + 1)}];
                     false -> []
                 end,
    Neighbors ++ Neighbors1 ++ Neighbors2 ++ Neighbors3 ++ Neighbors4.

get_grid_value(Grid, Row, Col) ->
    lists:nth(Col + 1, lists:nth(Row + 1, Grid)).

grid_size(Grid) ->
    Rows = length(Grid),
    Cols = length(lists:nth(1, Grid)),
    {Rows, Cols}.

infinity() -> 1000000000.