-module(check_if_word_can_be_placed_in_crossword).
-export([place_word_in_crossword/2]).

place_word_in_crossword(Board, Word) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    WordLength = length(Word),

    check_horizontal(Board, Rows, Cols, Word, WordLength) orelse
    check_horizontal(Board, Rows, Cols, lists:reverse(Word), WordLength) orelse
    check_vertical(Board, Board, Rows, Cols, Word, WordLength) orelse
    check_vertical(Board, Board, Rows, Cols, lists:reverse(Word), WordLength).

check_horizontal(Board, Rows, Cols, Word, WordLength) ->
    lists:any(fun(Row) ->
        lists:any(fun(Col) ->
            can_place_horizontal(Board, Rows, Cols, Row, Col, Word, WordLength)
        end, lists:seq(1, Cols))
    end, lists:seq(1, Rows)).

check_vertical(Board, Board, Rows, Cols, Word, WordLength) ->
    lists:any(fun(Col) ->
        lists:any(fun(Row) ->
            can_place_vertical(Board, Rows, Cols, Row, Col, Word, WordLength)
        end, lists:seq(1, Rows))
    end, lists:seq(1, Cols)).

can_place_horizontal(Board, Rows, Cols, Row, Col, Word, WordLength) ->
    if Col + WordLength - 1 > Cols ->
        false;
    true ->
        (Col =:= 1 orelse lists:nth(Row, lists:nth(Col-1, Board)) == '#') andalso
        (Col + WordLength - 1 =:= Cols orelse lists:nth(Row, lists:nth(Col + WordLength, Board)) == '#') andalso
        lists:all(fun(I) ->
            Char = lists:nth(I, Word),
            BoardChar = lists:nth(Row, lists:nth(Col + I - 1, Board)),
            BoardChar == ' ' orelse BoardChar == Char
        end, lists:seq(1, WordLength))
    end.

can_place_vertical(Board, Rows, Cols, Row, Col, Word, WordLength) ->
    if Row + WordLength - 1 > Rows ->
        false;
    true ->
        (Row =:= 1 orelse lists:nth(Row - 1, lists:nth(Col, Board)) == '#') andalso
        (Row + WordLength - 1 =:= Rows orelse lists:nth(Row + WordLength, lists:nth(Col, Board)) == '#') andalso
        lists:all(fun(I) ->
            Char = lists:nth(I, Word),
            BoardChar = lists:nth(Row + I - 1, lists:nth(Col, Board)),
            BoardChar == ' ' orelse BoardChar == Char
        end, lists:seq(1, WordLength))
    end.