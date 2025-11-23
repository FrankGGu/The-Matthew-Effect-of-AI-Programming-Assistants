-module(path_with_minimum_effort).
-export([findMinimumEffort/1]).

findMinimumEffort(Board) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    {MinEffort, _} = dijkstra(Board, Rows, Cols),
    MinEffort.

dijkstra(Board, Rows, Cols) ->
    Heap = erl_heap:new(),
    InitialState = {0, 0, 0},
    Heap1 = erl_heap:insert(Heap, InitialState),
    Visited = array:new({size, Rows * Cols}, {default, -1}),
    dijkstra_loop(Heap1, Board, Rows, Cols, Visited).

dijkstra_loop(Heap, Board, Rows, Cols, Visited) ->
    case erl_heap:is_empty(Heap) of
        true -> {infinity, Visited};
        false ->
            {Effort, Row, Col} = erl_heap:pop(Heap),
            Index = Row * Cols + Col,
            case array:get(Index, Visited) of
                Effort -> dijkstra_loop(Heap, Board, Rows, Cols, Visited);
                _ ->
                    NewVisited = array:set(Index, Effort, Visited),
                    if
                        Row == Rows - 1 andalso Col == Cols - 1 ->
                            {Effort, NewVisited};
                        true ->
                            Neighbors = get_neighbors(Row, Col, Rows, Cols),
                            NewHeap = process_neighbors(Neighbors, Effort, Row, Col, Board, Heap, NewVisited),
                            dijkstra_loop(NewHeap, Board, Rows, Cols, NewVisited)
                    end
    end.

process_neighbors([], _, _, _, _, Heap, _) -> Heap;
process_neighbors([{R, C} | Rest], CurrentEffort, Row, Col, Board, Heap, Visited) ->
    NewEffort = abs(Board![Row][Col] - Board![R][C]),
    TotalEffort = CurrentEffort + NewEffort,
    Index = R * length(hd(Board)) + C,
    case array:get(Index, Visited) of
        -1 ->
            NewHeap = erl_heap:insert(Heap, {TotalEffort, R, C}),
            process_neighbors(Rest, CurrentEffort, Row, Col, Board, NewHeap, Visited);
        ExistingEffort when ExistingEffort > TotalEffort ->
            NewHeap = erl_heap:insert(Heap, {TotalEffort, R, C}),
            process_neighbors(Rest, CurrentEffort, Row, Col, Board, NewHeap, Visited);
        _ ->
            process_neighbors(Rest, CurrentEffort, Row, Col, Board, Heap, Visited)
    end.

get_neighbors(Row, Col, Rows, Cols) ->
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    lists:filter(
        fun({DR, DC}) ->
            NewRow = Row + DR,
            NewCol = Col + DC,
            NewRow >= 0 andalso NewRow < Rows andalso NewCol >= 0 andalso NewCol < Cols
        end,
        Directions
    ).