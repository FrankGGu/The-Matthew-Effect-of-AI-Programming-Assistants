-module(surrounded_regions).
-export([solve/1]).

solve(Board) ->
    solve(Board, 0, 0, length(Board), length(hd(Board))).

solve(_, _, Y, _, _) when Y >= length(Board) ->
    Board;
solve(Board, X, Y, Rows, Cols) when X >= Cols ->
    solve(Board, 0, Y + 1, Rows, Cols);
solve(Board, X, Y, Rows, Cols) ->
    case lists:nth(Y + 1, Board) of
        Row when lists:nth(X + 1, Row) == $O ->
            case is_surrounded(Board, X, Y, Rows, Cols) of
                true -> set_cell(Board, X, Y, $X);
                false -> ok
            end;
        _ -> ok
    end,
    solve(Board, X + 1, Y, Rows, Cols).

is_surrounded(Board, X, Y, Rows, Cols) ->
    dfs(Board, X, Y, Rows, Cols, sets:new()).

dfs(Board, X, Y, Rows, Cols, Visited) ->
    case {X < 0, X >= Cols, Y < 0, Y >= Rows} of
        {true, _, _, _} -> false;
        {_, true, _, _} -> false;
        {_, _, true, _} -> false;
        {_, _, _, true} -> false;
        _ ->
            case lists:nth(Y + 1, Board) of
                Row when lists:nth(X + 1, Row) == $O ->
                    case sets:is_element({X, Y}, Visited) of
                        true -> true;
                        false ->
                            NewVisited = sets:add_element({X, Y}, Visited),
                            case dfs(Board, X - 1, Y, Rows, Cols, NewVisited) of
                                true -> true;
                                _ ->
                                    case dfs(Board, X + 1, Y, Rows, Cols, NewVisited) of
                                        true -> true;
                                        _ ->
                                            case dfs(Board, X, Y - 1, Rows, Cols, NewVisited) of
                                                true -> true;
                                                _ ->
                                                    dfs(Board, X, Y + 1, Rows, Cols, NewVisited)
                                            end
                                    end
                            end
                    end;
                _ -> false
            end
    end.

set_cell(Board, X, Y, Val) ->
    Row = lists:nth(Y + 1, Board),
    NewRow = set_cell_row(Row, X, Val),
    lists:sublist(Board, Y) ++ [NewRow] ++ lists:nthtail(Y + 1, Board).

set_cell_row(_, _, _) when [] == [] -> [];
set_cell_row(Row, X, Val) ->
    set_cell_row(Row, X, Val, 0).

set_cell_row([], _, _, _) -> [];
set_cell_row([H | T], X, Val, Index) ->
    if
        Index == X -> [Val | set_cell_row(T, X, Val, Index + 1)];
        true -> [H | set_cell_row(T, X, Val, Index + 1)]
    end.