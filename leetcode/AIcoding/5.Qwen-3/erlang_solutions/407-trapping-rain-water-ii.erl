-module(trapping_rain_water_ii).
-export([trapRainWater/1]).

trapRainWater(Grid) ->
    trapRainWater(Grid, []).

trapRainWater([], _) ->
    0;
trapRainWater(Grid, Heap) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Visited = array:new(Rows * Cols, {default, false}),
    Heap1 = build_heap(Grid, Visited),
    Dir = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    trap(Heap1, Grid, Visited, Dir, Rows, Cols).

build_heap(Grid, Visited) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    build_heap(Grid, Visited, 0, 0, []).

build_heap(Grid, Visited, Row, Col, Heap) when Row < length(Grid) ->
    build_heap(Grid, Visited, Row + 1, 0, add_to_heap(Grid, Visited, Row, Col, Heap));
build_heap(Grid, Visited, Row, Col, Heap) when Col < length(hd(Grid)) ->
    build_heap(Grid, Visited, Row, Col + 1, add_to_heap(Grid, Visited, Row, Col, Heap));
build_heap(_, _, _, _, Heap) ->
    Heap.

add_to_heap(Grid, Visited, Row, Col, Heap) ->
    Value = lists:nth(Col + 1, lists:nth(Row + 1, Grid)),
    Index = Row * length(hd(Grid)) + Col,
    array:set(Index, true, Visited),
    erlang:heap_insert(Heap, {Value, Row, Col}).

trap(Heap, Grid, Visited, Dir, Rows, Cols) ->
    case erlang:heap_pop(Heap) of
        {Value, Row, Col, NewHeap} ->
            Total = Value,
            lists:foreach(fun({DRow, DCol}) ->
                NewRow = Row + DRow,
                NewCol = Col + DCol,
                Index = NewRow * Cols + NewCol,
                if
                    NewRow >= 0, NewRow < Rows, NewCol >= 0, NewCol < Cols, not array:get(Index, Visited) ->
                        NewValue = lists:nth(NewCol + 1, lists:nth(NewRow + 1, Grid)),
                        NewVisited = array:set(Index, true, Visited),
                        NewHeap = erlang:heap_insert(NewHeap, {NewValue, NewRow, NewCol}),
                        trap(NewHeap, Grid, NewVisited, Dir, Rows, Cols);
                    true ->
                        ok
                end
            end, Dir),
            Total + trap(NewHeap, Grid, Visited, Dir, Rows, Cols);
        none ->
            0
    end.