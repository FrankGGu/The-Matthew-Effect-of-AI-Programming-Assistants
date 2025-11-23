-module(number_of_enclaves).
-export([num_enclaves/1]).

num_enclaves(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Visited = orddict:new(),

    flood_fill_border(Grid, Rows, Cols, Visited),

    count_enclaves(Grid, Rows, Cols, Visited, 0).

flood_fill_border(Grid, Rows, Cols, Visited) ->
    flood_fill_border(Grid, Rows, Cols, Visited, 0, 0, 0),
    flood_fill_border(Grid, Rows, Cols, Visited, 0, 0, 1).

flood_fill_border(Grid, Rows, Cols, Visited, R, C, Dir) ->
    case Dir of
        0 ->
            % Top and Bottom Row
            lists:foreach(fun(C) -> flood_fill(Grid, Rows, Cols, Visited, 0, C);
                            (C) -> flood_fill(Grid, Rows, Cols, Visited, Rows - 1, C) end,
                          lists:seq(0, Cols - 1));
        1 ->
            % Left and Right Column
            lists:foreach(fun(R) -> flood_fill(Grid, Rows, Cols, Visited, R, 0);
                            (R) -> flood_fill(Grid, Rows, Cols, Visited, R, Cols - 1) end,
                          lists:seq(0, Rows - 1))
    end.

flood_fill(Grid, Rows, Cols, Visited, R, C) ->
    if R < 0 or R >= Rows or C < 0 or C >= Cols then
        ok
    else
        case orddict:find({R, C}, Visited) of
            error ->
                case lists:nth(R + 1, Grid) of
                    Row ->
                        case lists:nth(C + 1, Row) of
                            1 ->
                                orddict:store({R, C}, true, Visited),
                                flood_fill(Grid, Rows, Cols, Visited, R + 1, C),
                                flood_fill(Grid, Rows, Cols, Visited, R - 1, C),
                                flood_fill(Grid, Rows, Cols, Visited, R, C + 1),
                                flood_fill(Grid, Rows, Cols, Visited, R, C - 1);
                            _ ->
                                ok
                        end;
                    _ ->
                        ok
                end;
            _ ->
                ok
        end
    end.

count_enclaves(Grid, Rows, Cols, Visited, Count) ->
    count_enclaves(Grid, Rows, Cols, Visited, 0, 0, Count).

count_enclaves(Grid, Rows, Cols, Visited, R, C, Count) ->
    if R >= Rows then
        Count
    else
        case orddict:find({R, C}, Visited) of
            error ->
                case lists:nth(R + 1, Grid) of
                    Row ->
                        case lists:nth(C + 1, Row) of
                            1 ->
                                NewCount = Count + 1,
                                NextR = if C == Cols - 1 then R + 1 else R end,
                                NextC = if C == Cols - 1 then 0 else C + 1 end,
                                count_enclaves(Grid, Rows, Cols, Visited, NextR, NextC, NewCount);
                            _ ->
                                NextR = if C == Cols - 1 then R + 1 else R end,
                                NextC = if C == Cols - 1 then 0 else C + 1 end,
                                count_enclaves(Grid, Rows, Cols, Visited, NextR, NextC, Count)
                        end;
                    _ ->
                        NextR = if C == Cols - 1 then R + 1 else R end,
                        NextC = if C == Cols - 1 then 0 else C + 1 end,
                        count_enclaves(Grid, Rows, Cols, Visited, NextR, NextC, Count)
                end;
            _ ->
                 NextR = if C == Cols - 1 then R + 1 else R end,
                 NextC = if C == Cols - 1 then 0 else C + 1 end,
                 count_enclaves(Grid, Rows, Cols, Visited, NextR, NextC, Count)
        end
    end.