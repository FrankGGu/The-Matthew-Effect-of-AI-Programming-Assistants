-module(minimum_path_cost).
-export([minimum_path_cost/2]).

minimum_path_cost(Grid, MoveCost) ->
    {Rows, Cols} = grid_size(Grid),
    Dist = lists:duplicate(Rows, lists:duplicate(Cols, infinity)),
    Dist = lists:update_element(0, lists:update_element(0, infinity, lists:nth(0, lists:nth(0, Grid))), Dist),

    queue:new() -> Queue0,
    Queue1 = queue:in({0,0}, Queue0),

    minimum_path_cost_helper(Grid, MoveCost, Dist, Queue1, Rows, Cols).

minimum_path_cost_helper(Grid, MoveCost, Dist, Queue, Rows, Cols) ->
    case queue:is_empty(Queue) of
        true ->
            lists:nth(Rows-1, lists:nth(Cols-1, Dist));
        false ->
            {{value, {Row, Col}}, Queue2} = queue:out(Queue),
            Cost = lists:nth(Col, lists:nth(Row, Dist)),
            Val = lists:nth(Col, lists:nth(Row, Grid)),
            minimum_path_cost_update(Grid, MoveCost, Dist, Queue2, Rows, Cols, Row, Col, Cost, Val).
    end.

minimum_path_cost_update(Grid, MoveCost, Dist, Queue, Rows, Cols, Row, Col, Cost, Val) ->
    NewDist = lists:nth(Row, lists:nth(Col, Dist)),

    Neighbors = get_neighbors(Row, Col, Rows, Cols),

    {NewDist1, Queue1} = lists:foldl(
        fun({NewRow, NewCol}, {AccDist, AccQueue}) ->
            MoveVal = lists:nth(NewCol, lists:nth(Val, MoveCost)),
            NewCost = Cost + MoveVal + lists:nth(NewCol, lists:nth(NewRow, Grid)),
            OldCost = lists:nth(NewCol, lists:nth(NewRow, AccDist)),

            if NewCost < OldCost then
                {lists:update_element(NewRow, lists:update_element(NewCol, infinity, NewCost), AccDist), queue:in({NewRow, NewCol}, AccQueue)}
            else
                {AccDist, AccQueue}
            end
        end,
        {Dist, Queue},
        Neighbors
    ),
    minimum_path_cost_helper(Grid, MoveCost, NewDist1, Queue1, Rows, Cols).

get_neighbors(Row, Col, Rows, Cols) ->
    Neighbors = [],
    Neighbors1 = case Row > 0 of
        true -> [{Row-1, Col} | Neighbors];
        false -> Neighbors
    end,
    Neighbors2 = case Row < Rows - 1 of
        true -> [{Row+1, Col} | Neighbors1];
        false -> Neighbors1
    end,
    Neighbors3 = case Col > 0 of
        true -> [{Row, Col-1} | Neighbors2];
        false -> Neighbors2
    end,
    case Col < Cols - 1 of
        true -> [{Row, Col+1} | Neighbors3];
        false -> Neighbors3
    end.

grid_size(Grid) ->
    Rows = length(Grid),
    Cols = length(lists:nth(0, Grid)),
    {Rows, Cols}.