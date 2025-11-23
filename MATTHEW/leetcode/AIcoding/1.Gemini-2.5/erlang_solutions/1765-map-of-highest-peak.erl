-module(solution).
-export([highestPeak/1]).

highestPeak(IsWater) ->
    M = length(IsWater),
    N = length(hd(IsWater)),

    % Helper to process a single row and build its initial state
    init_row(Row, RowIdx, N, AccQ, AccRowHeights) ->
        init_row(Row, RowIdx, N, 0, AccQ, AccRowHeights).

    init_row(_Row, _RowIdx, _N, N, AccQ, AccRowHeights) ->
        {AccQ, lists:reverse(AccRowHeights)};
    init_row(Row, RowIdx, N, ColIdx, AccQ, AccRowHeights) ->
        IsWaterVal = lists:nth(ColIdx + 1, Row),
        if
            IsWaterVal == 0 -> % Water cell
                NewAccQ = queue:in({{RowIdx, ColIdx}, 0}, AccQ),
                NewAccRowHeights = [0 | AccRowHeights],
                init_row(Row, RowIdx, N, ColIdx + 1, NewAccQ, NewAccRowHeights);
            true -> % Land cell
                NewAccRowHeights = [-1 | AccRowHeights],
                init_row(Row, RowIdx, N, ColIdx + 1, AccQ, NewAccRowHeights)
        end.

    % Main initialization loop for all rows
    init_grid(IsWater, M, N, AccQ, AccHeightsList) ->
        init_grid(IsWater, M, N, 0, AccQ, AccHeightsList).

    init_grid(_IsWater, M, _N, M, AccQ, AccHeightsList) ->
        {AccQ, lists:reverse(AccHeightsList)};
    init_grid(IsWater, M, N, RowIdx, AccQ, AccHeightsList) ->
        Row = lists:nth(RowIdx + 1, IsWater),
        {RowQ, RowHeights} = init_row(Row, RowIdx, N, queue:new(), []),
        NewAccQ = queue:join(AccQ, RowQ),
        NewAccHeightsList = [RowHeights | AccHeightsList],
        init_grid(IsWater, M, N, RowIdx + 1, NewAccQ, NewAccHeightsList).

    {FinalQueue, FinalHeightsList} = init_grid(IsWater, M, N, queue:new(), []),

    % Convert list of lists to array of arrays for efficient updates
    HeightsArray = array:from_list(
        lists:map(fun(RowList) -> array:from_list(RowList) end, FinalHeightsList)
    ),

    % BFS
    bfs(FinalQueue, HeightsArray, M, N).

bfs(Queue, Heights, M, N) ->
    case queue:out(Queue) of
        {{value, {{R, C}, CurrentHeight}}, RestQueue} ->
            Neighbors = [
                {R - 1, C}, {R + 1, C}, {R, C - 1}, {R, C + 1}
            ],

            {NewQueue, NewHeights} = lists:foldl(
                fun({NR, NC}, {AccQ, AccHeights}) ->
                    % Check bounds
                    if
                        NR >= 0 andalso NR < M andalso NC >= 0 andalso NC < N ->
                            NeighborRow = array:get(NR, AccHeights),
                            NeighborHeight = array:get(NC, NeighborRow),

                            if
                                NeighborHeight == -1 -> % Unvisited land cell
                                    UpdatedNeighborRow = array:set(NC, CurrentHeight + 1, NeighborRow),
                                    UpdatedAccHeights = array:set(NR, UpdatedNeighborRow, AccHeights),
                                    UpdatedAccQ = queue:in({{NR, NC}, CurrentHeight + 1}, AccQ),
                                    {UpdatedAccQ, UpdatedAccHeights};
                                true ->
                                    {AccQ, AccHeights}
                            end;
                        true ->
                            {AccQ, AccHeights}
                    end
                end,
                {RestQueue, Heights},
                Neighbors
            ),
            bfs(NewQueue, NewHeights, M, N);
        {empty, _} ->
            % Queue is empty, BFS finished. Convert array of arrays back to list of lists.
            array:to_list(
                array:map(fun(RowArray) -> array:to_list(RowArray) end, Heights)
            )
    end.