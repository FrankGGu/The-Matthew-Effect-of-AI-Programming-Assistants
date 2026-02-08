-module(solution).
-export([place_word_in_crossword/2]).

place_word_in_crossword(Board, Word) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    WordLen = length(Word),
    place_word_in_crossword(Board, Word, 0, 0, Rows, Cols, WordLen).

place_word_in_crossword(_, _, _, _, _, _, 0) -> true;
place_word_in_crossword(Board, Word, R, C, Rows, Cols, Len) ->
    case R of
        Rows -> false;
        _ ->
            case C of
                Cols -> place_word_in_crossword(Board, Word, R+1, 0, Rows, Cols, Len);
                _ ->
                    case is_start(Board, R, C, Rows, Cols) of
                        true ->
                            case check_horizontal(Board, Word, R, C, Cols, Len) of
                                true -> true;
                                _ -> place_word_in_crossword(Board, Word, R, C+1, Rows, Cols, Len)
                            end;
                        false ->
                            place_word_in_crossword(Board, Word, R, C+1, Rows, Cols, Len)
                    end
            end
    end.

is_start(Board, R, C, Rows, Cols) ->
    case C of
        0 -> true;
        _ when C > 0 -> is_cell_empty(Board, R, C-1, Rows, Cols)
    end,
    case C of
        Cols-1 -> true;
        _ -> is_cell_empty(Board, R, C+1, Rows, Cols)
    end.

is_cell_empty(Board, R, C, Rows, Cols) ->
    case R of
        R when R >= Rows -> true;
        _ ->
            case C of
                C when C >= Cols -> true;
                _ -> lists:nth(R+1, Board) -- [C+1] == []
            end
    end.

check_horizontal(Board, Word, R, C, Cols, Len) ->
    if
        C + Len > Cols -> false;
        true ->
            check_horizontal(Board, Word, R, C, Cols, Len, 0)
    end.

check_horizontal(_, _, _, _, _, 0, _) -> true;
check_horizontal(Board, Word, R, C, Cols, Len, I) ->
    if
        I >= Len -> true;
        true ->
            case C + I >= Cols of
                true -> false;
                _ ->
                    case lists:nth(R+1, Board) -- [C + I + 1] of
                        [] -> check_horizontal(Board, Word, R, C, Cols, Len, I+1);
                        _ -> false
                    end
            end
    end.