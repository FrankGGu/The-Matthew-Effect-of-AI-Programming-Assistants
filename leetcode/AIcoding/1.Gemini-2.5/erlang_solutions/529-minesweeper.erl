-module(minesweeper).
-export([updateBoard/2]).

updateBoard(Board, [R, C]) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    CurrentChar = get_char(Board, R, C),

    if CurrentChar == $M ->
        set_char(Board, R, C, $X);
    CurrentChar == $E ->
        MineCount = count_adjacent_mines(Board, R, C, Rows, Cols),
        if MineCount > 0 ->
            set_char(Board, R, C, $0 + MineCount);
        true ->
            dfs(Board, R, C, Rows, Cols)
        end;
    true ->
        Board
    end.

get_char(Board, R, C) ->
    lists:nth(C + 1, lists:nth(R + 1, Board)).

set_char(Board, R, C, NewChar) ->
    RowList = lists:nth(R + 1, Board),
    NewRowList = lists:replace_at(C + 1, NewChar, RowList),
    lists:replace_at(R + 1, NewRowList, Board).

is_valid(Rows, Cols, R, C) ->
    R >= 0 and R < Rows and C >= 0 and C < Cols.

count_adjacent_mines(Board, R, C, Rows, Cols) ->
    Directions = [[-1, -1], [-1, 0], [-1, 1],
                  [0, -1],           [0, 1],
                  [1, -1],  [1, 0],  [1, 1]],
    lists:foldl(fun([DR, DC], Acc) ->
                    NR = R + DR,
                    NC = C + DC,
                    if is_valid(Rows, Cols, NR, NC) andalso get_char(Board, NR, NC) == $M ->
                        Acc + 1;
                    true ->
                        Acc
                    end
                end, 0, Directions).

dfs(Board, R, C, Rows, Cols) ->
    if not is_valid(Rows, Cols, R, C) ->
        Board;
    get_char(Board, R, C) /= $E ->
        Board;
    true ->
        MineCount = count_adjacent_mines(Board, R, C, Rows, Cols),
        UpdatedBoard1 =
            if MineCount > 0 ->
                set_char(Board, R, C, $0 + MineCount);
            true ->
                set_char(Board, R, C, $B)
            end,

        if MineCount > 0 ->
            UpdatedBoard1;
        true ->
            Directions = [[-1, -1], [-1, 0], [-1, 1],
                          [0, -1],           [0, 1],
                          [1, -1],  [1, 0],  [1, 1]],
            lists:foldl(fun([DR, DC], CurrentBoard) ->
                            dfs(CurrentBoard, R + DR, C + DC, Rows, Cols)
                        end, UpdatedBoard1, Directions)
        end
    end.