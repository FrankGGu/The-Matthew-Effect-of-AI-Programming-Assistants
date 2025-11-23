-module(trapping_rain_water_ii).
-export([trapRainWater/1]).

trapRainWater(HeightMap) ->
    case HeightMap of
        [] -> 0;
        _ ->
            Rows = length(HeightMap),
            Cols = length(hd(HeightMap)),
            if Rows < 3 or Cols < 3 ->
                0
            else
                do_trapRainWater(HeightMap, Rows, Cols)
            end
    end.

do_trapRainWater(HeightMap, Rows, Cols) ->
    {PriorityQueue, Visited} = initialize(HeightMap, Rows, Cols),
    trap(HeightMap, PriorityQueue, Visited, Rows, Cols, 0).

initialize(HeightMap, Rows, Cols) ->
    PriorityQueue = gb_sets:empty(),
    Visited = array:new([Rows, Cols], {fixed, false}),
    {PQ, V} = lists:foldl(
        fun(Row, {PQAcc, VAcc}) ->
            lists:foldl(
                fun(Col, {PQAcc2, VAcc2}) ->
                    if Row == 0 or Row == Rows - 1 or Col == 0 or Col == Cols - 1 ->
                        Height = lists:nth(Row, HeightMap) !! Col,
                        {gb_sets:add({Height, {Row, Col}}, PQAcc2), array:set({Row, Col}, true, VAcc2)}
                    else
                        {PQAcc2, VAcc2}
                    end
                end,
                {PQAcc, VAcc},
                lists:seq(0, Cols - 1)
            )
        end,
        {PriorityQueue, Visited},
        lists:seq(0, Rows - 1)
    ),
    {PQ, V}.

trap(HeightMap, PriorityQueue, Visited, Rows, Cols, Water) ->
    case gb_sets:is_empty(PriorityQueue) of
        true ->
            Water;
        false ->
            {{Height, {Row, Col}}, RestQueue} = gb_sets:take_smallest(PriorityQueue),
            {NewWater, NewPriorityQueue, NewVisited} =
                lists:foldl(
                    fun({DRow, DCol}, {WaterAcc, PQAcc, VAcc}) ->
                        NewRow = Row + DRow,
                        NewCol = Col + DCol,
                        if NewRow >= 0 and NewRow < Rows and NewCol >= 0 and NewCol < Cols and not array:get({NewRow, NewCol}, VAcc) ->
                            array:set({NewRow, NewCol}, true, VAcc1) = VAcc,
                            NewHeight = lists:nth(NewRow, HeightMap) !! NewCol,
                            if NewHeight < Height ->
                                {WaterAcc + (Height - NewHeight), gb_sets:add({Height, {NewRow, NewCol}}, PQAcc), VAcc1}
                            else
                                {WaterAcc, gb_sets:add({NewHeight, {NewRow, NewCol}}, PQAcc), VAcc1}
                            else
                                {WaterAcc, PQAcc, VAcc}
                        end
                    end,
                    {Water, RestQueue, Visited},
                    [{0, 1}, {0, -1}, {1, 0}, {-1, 0}]
                ),
            trap(HeightMap, NewPriorityQueue, NewVisited, Rows, Cols, NewWater)
    end.