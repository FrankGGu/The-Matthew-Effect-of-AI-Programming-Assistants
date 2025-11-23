-module(solution).
-export([max_paths/1]).

max_paths(Board) ->
    Max = 0,
    Count = 0,
    {Max, Count} = dfs(Board, 0, 0, 0, 0),
    Count.

dfs(_, Row, Col, _, _) when Row >= length(Board) orelse Col >= length(hd(Board)) ->
    {0, 0};
dfs(Board, Row, Col, Max, Count) ->
    Current = lists:nth(Row + 1, Board),
    Char = lists:nth(Col + 1, Current),
    if
        Char == $* -> {0, 1};
        true ->
            NextRow = Row + 1,
            NextCol = Col + 1,
            {RightMax, RightCount} = dfs(Board, Row, NextCol, Max, Count),
            {DownMax, DownCount} = dfs(Board, NextRow, Col, Max, Count),
            {DiagMax, DiagCount} = dfs(Board, NextRow, NextCol, Max, Count),
            NewMax = max(RightMax, max(DownMax, DiagMax)),
            NewCount = case NewMax of
                          RightMax -> RightCount;
                          DownMax -> DownCount;
                          DiagMax -> DiagCount;
                          _ -> 0
                      end,
            case NewMax of
                0 -> {0, 0};
                _ -> {NewMax + (if Char == $M -> 0; true -> 1 end), NewCount}
            end
    end.