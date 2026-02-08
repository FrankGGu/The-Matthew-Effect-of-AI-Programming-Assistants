-module(shortest_path_obstacles).
-export([shortest_path/3]).

shortest_path(Grid, K, Start) ->
    {Rows, Cols} = grid_size(Grid),
    {StartRow, StartCol} = Start,
    Queue = queue:new(),
    queue:in({StartRow, StartCol, K, 0}, Queue),
    Visited = sets:new(),
    shortest_path_helper(Grid, Rows, Cols, Queue, Visited).

shortest_path_helper(Grid, Rows, Cols, Queue, Visited) ->
    case queue:out(Queue) of
        {{value, {Row, Col, K, Steps}}, NewQueue} ->
            if Row == Rows - 1, Col == Cols - 1 ->
                Steps;
            true ->
                Neighbors = get_neighbors(Row, Col, Rows, Cols),
                NewVisited = sets:add({Row, Col, K}, Visited),
                NewQueue2 = lists:foldl(
                    fun({NewRow, NewCol}, AccQueue) ->
                        case get_grid_value(Grid, NewRow, NewCol) of
                            0 ->
                                if not sets:is_element({NewRow, NewCol, K}, NewVisited) ->
                                    queue:in({NewRow, NewCol, K, Steps + 1}, AccQueue);
                                true ->
                                    AccQueue
                                end;
                            1 ->
                                if K > 0, not sets:is_element({NewRow, NewCol, K - 1}, NewVisited) ->
                                    queue:in({NewRow, NewCol, K - 1, Steps + 1}, AccQueue);
                                true ->
                                    AccQueue
                                end
                        end
                    end,
                    NewQueue,
                    Neighbors
                ),
                shortest_path_helper(Grid, Rows, Cols, NewQueue2, NewVisited)
            end;
        empty ->
            -1
    end.

get_neighbors(Row, Col, Rows, Cols) ->
    Neighbors = [],
    Neighbors1 = if Row > 0 -> [{Row - 1, Col}] else [] end,
    Neighbors2 = if Row < Rows - 1 -> [{Row + 1, Col}] else [] end,
    Neighbors3 = if Col > 0 -> [{Row, Col - 1}] else [] end,
    Neighbors4 = if Col < Cols - 1 -> [{Row, Col + 1}] else [] end,
    Neighbors1 ++ Neighbors2 ++ Neighbors3 ++ Neighbors4.

get_grid_value(Grid, Row, Col) ->
    lists:nth(Col + 1, lists:nth(Row + 1, Grid)).

grid_size(Grid) ->
    Rows = length(Grid),
    Cols = length(lists:nth(1, Grid)),
    {Rows, Cols}.