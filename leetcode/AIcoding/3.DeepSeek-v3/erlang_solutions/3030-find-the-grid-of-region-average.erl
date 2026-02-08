-spec region_average(Image :: [[integer()]], Threshold :: integer()) -> [[float()]].
region_average(Image, Threshold) ->
    Rows = length(Image),
    Cols = length(hd(Image)),
    Visited = lists:duplicate(Rows, lists:duplicate(Cols, false)),
    {Result, _} = lists:mapfoldl(fun(Row, AccVisited) ->
        {NewRow, NewAccVisited} = lists:mapfoldl(fun(Col, RowVisited) ->
            case lists:nth(Col + 1, RowVisited) of
                false ->
                    {Sum, Count, NewVisited} = bfs(Image, Rows, Cols, Row, Col, Threshold, AccVisited),
                    Avg = case Count of
                        0 -> 0.0;
                        _ -> Sum / Count
                    end,
                    {Avg, NewVisited};
                true ->
                    {0.0, RowVisited}
            end
        end, AccVisited, lists:seq(0, Cols - 1)),
        {NewRow, NewAccVisited}
    end, Visited, lists:seq(0, Rows - 1)),
    Result.

bfs(Image, Rows, Cols, StartRow, StartCol, Threshold, Visited) ->
    Queue = [{StartRow, StartCol}],
    InitialVisited = set_visited(StartRow, StartCol, Visited),
    bfs_helper(Image, Rows, Cols, Queue, Threshold, InitialVisited, 0, 0).

bfs_helper(Image, Rows, Cols, Queue, Threshold, Visited, Sum, Count) ->
    case Queue of
        [] -> {Sum, Count, Visited};
        [{Row, Col} | Rest] ->
            Value = lists:nth(Col + 1, lists:nth(Row + 1, Image)),
            NewSum = Sum + Value,
            NewCount = Count + 1,
            Neighbors = [{R, C} || {R, C} <- [{Row - 1, Col}, {Row + 1, Col}, {Row, Col - 1}, {Row, Col + 1}],
                                    R >= 0, R < Rows, C >= 0, C < Cols,
                                    not is_visited(R, C, Visited),
                                    abs(lists:nth(C + 1, lists:nth(R + 1, Image)) - Value) =< Threshold],
            NewVisited = lists:foldl(fun({R, C}, Acc) -> set_visited(R, C, Acc) end, Visited, Neighbors),
            NewQueue = Rest ++ Neighbors,
            bfs_helper(Image, Rows, Cols, NewQueue, Threshold, NewVisited, NewSum, NewCount)
    end.

is_visited(Row, Col, Visited) ->
    lists:nth(Col + 1, lists:nth(Row + 1, Visited)).

set_visited(Row, Col, Visited) ->
    RowList = lists:nth(Row + 1, Visited),
    NewRowList = setelement(Col + 1, list_to_tuple(RowList), true),
    setelement(Row + 1, list_to_tuple(Visited), list_to_tuple(NewRowList)).