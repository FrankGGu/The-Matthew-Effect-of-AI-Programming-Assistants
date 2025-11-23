-module(solution).
-export([lastDayWhereYouCanStillCross/3]).

lastDayWhereYouCanStillCross(Row, Col, Cells) ->
    BinarySearch(0, length(Cells), 0, Row, Col, Cells).

BinarySearch(Low, High, CurrentAns, R, C, Cells) ->
    case Low =< High of
        true ->
            Mid = Low + (High - Low) div 2,
            case check(Mid, R, C, Cells) of
                true ->
                    BinarySearch(Mid + 1, High, Mid, R, C, Cells);
                false ->
                    BinarySearch(Low, Mid - 1, CurrentAns, R, C, Cells)
            end;
        false ->
            CurrentAns
    end.

check(K, R, C, Cells) ->
    Grid = array:new([{0, R-1}, {0, C-1}], 0),

    FloodedGrid = flood_cells(K, Cells, Grid),

    Q = queue:new(),
    Visited = sets:new(),

    {Q1, Visited1} = lists:foldl(
        fun(Col, {AccQ, AccVisited}) ->
            case array:get({0, Col}, FloodedGrid) of
                0 ->
                    {queue:in({0, Col}, AccQ), sets:add({0, Col}, AccVisited)};
                _ -> {AccQ, AccVisited}
            end
        end,
        {Q, Visited},
        lists:seq(0, C-1)
    ),

    bfs(R, C, FloodedGrid, Q1, Visited1).

flood_cells(K, Cells, Grid) ->
    FloodedCells = lists:sublist(Cells, K),
    lists:foldl(
        fun([Row, Col], AccGrid) ->
            array:set({Row-1, Col-1}, 1, AccGrid)
        end,
        Grid,
        FloodedCells
    ).

bfs(R, C, Grid, Q, Visited) ->
    case queue:is_empty(Q) of
        true -> false;
        false ->
            {{CurrR, CurrC}, Q1} = queue:out(Q),
            case CurrR == R - 1 of
                true -> true;
                false ->
                    Neighbors = [{CurrR-1, CurrC}, {CurrR+1, CurrC}, {CurrR, CurrC-1}, {CurrR, CurrC+1}],
                    {Q2, Visited2} = lists:foldl(
                        fun({NR, NC}, {AccQ, AccVisited}) ->
                            case (NR >= 0 andalso NR < R andalso NC >= 0 andalso NC < C) of
                                true ->
                                    case array:get({NR, NC}, Grid) of
                                        0 ->
                                            case sets:is_element({NR, NC}, AccVisited) of
                                                false ->
                                                    {queue:in({NR, NC}, AccQ), sets:add({NR, NC}, AccVisited)};
                                                true -> {AccQ, AccVisited}
                                            end;
                                        _ -> {AccQ, AccVisited}
                                    end;
                                false -> {AccQ, AccVisited}
                            end
                        end,
                        {Q1, Visited},
                        Neighbors
                    ),
                    bfs(R, C, Grid, Q2, Visited2)
            end
    end.