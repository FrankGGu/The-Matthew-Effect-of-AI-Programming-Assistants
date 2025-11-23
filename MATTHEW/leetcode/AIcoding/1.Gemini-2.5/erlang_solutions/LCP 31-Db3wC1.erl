-module(solution).
-export([solve/1]).

solve(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),

    {StartR, StartC, EndR, EndC} = find_start_end_coords(Grid, Rows, Cols),

    Q = queue:in({StartR, StartC, 0}, queue:new()),
    Visited = gb_sets:add({StartR, StartC, 0}, gb_sets:new()),

    bfs(Q, Visited, Grid, Rows, Cols, EndR, EndC).

find_start_end_coords(Grid, Rows, Cols) ->
    find_start_end_coords(Grid, 0, Rows, Cols, -1, -1, -1, -1).

find_start_end_coords([], _R, _Rows, _Cols, SR, SC, ER, EC) ->
    {SR, SC, ER, EC};
find_start_end_coords([RowStr | RestGrid], R, Rows, Cols, CurrentSR, CurrentSC, CurrentER, CurrentEC) ->
    {NextSR, NextSC, NextER, NextEC} = find_start_end_in_row(RowStr, R, 0, Cols, CurrentSR, CurrentSC, CurrentER, CurrentEC),
    find_start_end_coords(RestGrid, R + 1, Rows, Cols, NextSR, NextSC, NextER, NextEC).

find_start_end_in_row([], _R, _C, _Cols, SR, SC, ER, EC) ->
    {SR, SC, ER, EC};
find_start_end_in_row([Char | RestRow], R, C, Cols, CurrentSR, CurrentSC, CurrentER, CurrentEC) ->
    NewSR = case Char of $S -> R; _ -> CurrentSR end,
    NewSC = case Char of $S -> C; _ -> CurrentSC end,
    NewER = case Char of $E -> R; _ -> CurrentER end,
    NewEC = case Char of $E -> C; _ -> CurrentEC end,
    find_start_end_in_row(RestRow, R, C + 1, Cols, NewSR, NewSC, NewER, NewEC).

bfs(Q, _Visited, _Grid, _Rows, _Cols, _EndR, _EndC) when queue:is_empty(Q) ->
    -1;
bfs(Q, Visited, Grid, Rows, Cols, EndR, EndC) ->
    {{value, {R, C, Time}}, NewQ} = queue:out(Q),

    if R == EndR andalso C == EndC ->
        Time;
    true ->
        NewTime = Time + 1,
        Moves = [{R-1, C}, {R+1, C}, {R, C-1}, {R, C+1}],

        {UpdatedQ, UpdatedVisited} = lists:foldl(
            fun({NR, NC}, {AccQ, AccVisited}) ->
                if NR >= 0 andalso NR < Rows andalso NC >= 0 andalso NC < Cols ->
                    RowString = lists:nth(NR + 1, Grid),
                    CellChar = lists:nth(NC + 1, RowString),

                    IsBlocked = case CellChar of
                                    $# -> true;
                                    $T -> NewTime rem 2 == 0;
                                    _ -> false
                                end,

                    NewState = {NR, NC, NewTime},
                    if not IsBlocked andalso not gb_sets:is_element(NewState, AccVisited) ->
                        {queue:in(NewState, AccQ), gb_sets:add(NewState, AccVisited)};
                    true ->
                        {AccQ, AccVisited}
                    end;
                true ->
                    {AccQ, AccVisited}
                end
            end,
            {NewQ, Visited},
            Moves
        ),
        bfs(UpdatedQ, UpdatedVisited, Grid, Rows, Cols, EndR, EndC)
    end.