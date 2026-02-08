-module(minimum_time_to_visit_a_cell_in_a_grid).
-export([minimum_time/1]).

minimum_time(Grid) ->
    {Rows, Cols} = grid_size(Grid),
    Dists = array:new([{fixed, Rows}, {fixed, Cols}], infinity),
    array:set({0, 0}, 0, Dists),
    Q = gb_sets:from_list([{0, 0, 0}]), % {time, row, col}

    case solve(Grid, Dists, Q, Rows, Cols) of
        infinity -> -1;
        Time -> Time
    end.

solve(Grid, Dists, Q, Rows, Cols) ->
    case gb_sets:is_empty(Q) of
        true ->
            array:get({Rows - 1, Cols - 1}, Dists);
        false ->
            {_, {Time, Row, Col}, Q1} = gb_sets:take_smallest(Q),
            Neighbors = get_neighbors(Row, Col, Rows, Cols),
            Updated_Q = lists:foldl(
                fun({NewRow, NewCol}, AccQ) ->
                    NewTime = max(Time + 1, Grid[NewRow][NewCol]),
                    Dist = array:get({NewRow, NewCol}, Dists),
                    if NewTime < Dist then
                        array:set({NewRow, NewCol}, NewTime, Dists1),
                        gb_sets:add({NewTime, NewRow, NewCol}, AccQ)
                    else
                        AccQ
                    end
                end,
                Q1,
                Neighbors
            ),
            solve(Grid, Dists, Updated_Q, Rows, Cols)
    end.

get_neighbors(Row, Col, Rows, Cols) ->
    Neighbors = [],
    if Row > 0 then
        Neighbors1 = [{Row - 1, Col} | Neighbors],
        if Row < Rows - 1 then
            Neighbors2 = [{Row + 1, Col} | Neighbors1],
            if Col > 0 then
                Neighbors3 = [{Row, Col - 1} | Neighbors2],
                if Col < Cols - 1 then
                    [{Row, Col + 1} | Neighbors3]
                else
                    Neighbors3
                end
            else
                if Col < Cols - 1 then
                    Neighbors4 = [{Row, Col + 1} | Neighbors2],
                    Neighbors4
                else
                    Neighbors2
                end
            end
        else
            if Col > 0 then
                Neighbors5 = [{Row, Col - 1} | Neighbors1],
                if Col < Cols - 1 then
                    [{Row, Col + 1} | Neighbors5]
                else
                    Neighbors5
                end
            else
                if Col < Cols - 1 then
                    Neighbors6 = [{Row, Col + 1} | Neighbors1],
                    Neighbors6
                else
                    Neighbors1
                end
            end
        end
    else
        if Row < Rows - 1 then
            Neighbors7 = [{Row + 1, Col} | Neighbors],
            if Col > 0 then
                Neighbors8 = [{Row, Col - 1} | Neighbors7],
                if Col < Cols - 1 then
                    [{Row, Col + 1} | Neighbors8]
                else
                    Neighbors8
                end
            else
                if Col < Cols - 1 then
                    Neighbors9 = [{Row, Col + 1} | Neighbors7],
                    Neighbors9
                else
                    Neighbors7
                end
            end
        else
            if Col > 0 then
                Neighbors10 = [{Row, Col - 1} | Neighbors],
                if Col < Cols - 1 then
                    [{Row, Col + 1} | Neighbors10]
                else
                    Neighbors10
                end
            else
                if Col < Cols - 1 then
                    Neighbors11 = [{Row, Col + 1} | Neighbors],
                    Neighbors11
                else
                    []
                end
            end
        end
    end.

grid_size(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    {Rows, Cols}.

infinity() ->
    16#7fffffff#.