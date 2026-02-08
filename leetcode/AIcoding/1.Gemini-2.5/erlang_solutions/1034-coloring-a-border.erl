-module(solution).
-export([colorBorder/4]).

colorBorder(Grid, R0, C0, Color) ->
    M = length(Grid),
    N = length(hd(Grid)),
    OriginalColor = lists:nth(C0 + 1, lists:nth(R0 + 1, Grid)),

    Queue = queue:new(),
    Queue1 = queue:in({R0, C0}, Queue),
    Visited = sets:add_element({R0, C0}, sets:new()),
    BorderCells = [],

    {_FinalQueue, _FinalVisited, FinalBorderCells} = 
        bfs_loop(Queue1, Grid, OriginalColor, M, N, Visited, BorderCells),

    NewGrid = lists:foldl(
        fun({R, C}, AccGrid) ->
            Row = lists:nth(R + 1, AccGrid),
            NewRow = lists:replace_nth(C + 1, Color, Row),
            lists:replace_nth(R + 1, NewRow, AccGrid)
        end,
        Grid,
        FinalBorderCells
    ),
    NewGrid.

bfs_loop(Queue, Grid, OriginalColor, M, N, VisitedAcc, BorderCellsAcc) ->
    case queue:out(Queue) of
        {{value, {R, C}}, Queue1} ->
            IsBorder = check_border(Grid, R, C, OriginalColor, M, N),
            BorderCells1 = if IsBorder -> [{R, C} | BorderCellsAcc]; true -> BorderCellsAcc end,

            Neighbors = [{R+1, C}, {R-1, C}, {R, C+1}, {R, C-1}],
            {Queue2, Visited1} = lists:foldl(
                fun({NR, NC}, {CurrentQueue, CurrentVisited}) ->
                    if NR >= 0, NR < M, NC >= 0, NC < N,
                       lists:nth(NC + 1, lists:nth(NR + 1, Grid)) == OriginalColor,
                       not sets:is_element({NR, NC}, CurrentVisited) ->
                        {queue:in({NR, NC}, CurrentQueue), sets:add_element({NR, NC}, CurrentVisited)};
                    true ->
                        {CurrentQueue, CurrentVisited}
                    end
                end,
                {Queue1, VisitedAcc},
                Neighbors
            ),
            bfs_loop(Queue2, Grid, OriginalColor, M, N, Visited1, BorderCells1);
        {empty, _} ->
            {Queue, VisitedAcc, BorderCellsAcc}
    end.

check_border(Grid, R, C, OriginalColor, M, N) ->
    Neighbors = [{R+1, C}, {R-1, C}, {R, C+1}, {R, C-1}],
    lists:any(fun({NR, NC}) ->
                not (NR >= 0 and NR < M and NC >= 0 and NC < N and
                     lists:nth(NC + 1, lists:nth(NR + 1, Grid)) == OriginalColor)
            end, Neighbors).