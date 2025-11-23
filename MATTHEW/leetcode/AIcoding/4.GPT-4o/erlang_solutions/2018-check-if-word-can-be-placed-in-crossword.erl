-module(solution).
-export([place_word_in_crossword/3]).

place_word_in_crossword(Board, Word, Height) ->
    WordLen = length(Word),
    lists:any(fun(Row) -> can_place_horizontal(Row, Word) end, Board) orelse
    lists:any(fun(Col) -> can_place_vertical(Board, Col, Word) end, lists:seq(1, Height)).

can_place_horizontal(Row, Word) ->
    WordLen = length(Word),
    lists:foldl(fun(_, Acc) -> Acc orelse check_slot(Acc, Row, Word) end, false, lists:seq(1, length(Row) - WordLen + 1)).

check_slot(Start, Row, Word) ->
    SubRow = lists:sublist(Row, Start, length(Word)),
    valid_slot(SubRow, Word).

valid_slot([], _) -> true;
valid_slot([H | T], [W | WRest]) ->
    (H = $\s; H = W) andalso valid_slot(T, WRest);
valid_slot(_, _) -> false.

can_place_vertical(Board, Col, Word) ->
    WordLen = length(Word),
    SubCol = lists:map(fun(Row) -> lists:nth(Col, Row) end, lists:sublist(Board, 1, WordLen)),
    valid_slot(SubCol, Word).