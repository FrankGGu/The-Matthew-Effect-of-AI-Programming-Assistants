-module(surrounded_regions).
-export([solve/1]).

solve(Board) ->
    case Board of
        [] -> [];
        _ ->
            Rows = length(Board),
            Cols = length(hd(Board)),
            Marked = lists:seq(0, Rows - 1),
            Marked2 = lists:seq(0, Cols - 1),
            Marked3 = lists:seq(0, Rows - 1),
            Marked4 = lists:seq(0, Cols - 1),
            lists:foreach(fun(R) -> dfs(Board, R, 0, Rows, Cols, Marked, Marked2, Marked3, Marked4) end, Marked),
            lists:foreach(fun(R) -> dfs(Board, R, Cols - 1, Rows, Cols, Marked, Marked2, Marked3, Marked4) end, Marked),
            lists:foreach(fun(C) -> dfs(Board, 0, C, Rows, Cols, Marked, Marked2, Marked3, Marked4) end, Marked2),
            lists:foreach(fun(C) -> dfs(Board, Rows - 1, C, Rows, Cols, Marked, Marked2, Marked3, Marked4) end, Marked2),
            lists:foreach(fun(R) -> lists:foreach(fun(C) -> case lists:nth(R + 1, Board) of [H | T] when H == $O -> lists:put(R + 1, lists:put(C + 1, $X, lists:nth(R + 1, Board)), Board); _ -> ok end end, Marked3) end, Marked4),
            Board
    end.

dfs(_, _, _, _, _, _, _, _, _) -> ok;
dfs(Board, R, C, Rows, Cols, Marked, Marked2, Marked3, Marked4) ->
    case (R < 0) or (R >= Rows) or (C < 0) or (C >= Cols) of
        true -> ok;
        false ->
            case lists:nth(R + 1, Board) of
                [H | T] when H == $O ->
                    lists:put(R + 1, lists:put(C + 1, $T, lists:nth(R + 1, Board)), Board),
                    dfs(Board, R - 1, C, Rows, Cols, Marked, Marked2, Marked3, Marked4),
                    dfs(Board, R + 1, C, Rows, Cols, Marked, Marked2, Marked3, Marked4),
                    dfs(Board, R, C - 1, Rows, Cols, Marked, Marked2, Marked3, Marked4),
                    dfs(Board, R, C + 1, Rows, Cols, Marked, Marked2, Marked3, Marked4);
                _ -> ok
            end
    end.