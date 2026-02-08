-module(detect_cycles_in_2d_grid).
-export([has_cycle/1]).

has_cycle(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Visited = array:new({size, Rows * Cols}, {default, false}),
    has_cycle(Grid, 0, 0, Visited, -1, -1).

has_cycle(_, _, _, _, _, _) -> false.

has_cycle(Grid, R, C, Visited, PR, PC) ->
    Row = R,
    Col = C,
    case array:get(R * Cols + C, Visited) of
        true -> true;
        _ ->
            array:set(R * Cols + C, true, Visited),
            Value = lists:nth(R + 1, Grid),
            Val = lists:nth(C + 1, Value),
            Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
            lists:foldl(fun({DR, DC}, Acc) ->
                            NR = R + DR,
                            NC = C + DC,
                            if
                                NR >= 0, NR < Rows, NC >= 0, NC < Cols,
                                (NR /= PR orelse NC /= PC) ->
                                    case lists:nth(NR + 1, Grid) of
                                        RowData when is_list(RowData) ->
                                            CaseVal = lists:nth(NC + 1, RowData),
                                            if
                                                CaseVal == Val ->
                                                    case has_cycle(Grid, NR, NC, Visited, R, C) of
                                                        true -> true;
                                                        _ -> Acc
                                                    end;
                                                _ -> Acc
                                            end;
                                        _ -> Acc
                                    end;
                                true -> Acc
                            end
                        end, false, Directions).