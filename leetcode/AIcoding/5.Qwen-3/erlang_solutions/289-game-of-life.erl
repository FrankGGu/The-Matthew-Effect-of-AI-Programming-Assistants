-module(game_of_life).
-export([game_of_life/1]).

game_of_life(Board) ->
    game_of_life(Board, 0, length(Board), []).

game_of_life(_, _, 0, Acc) ->
    lists:reverse(Acc);
game_of_life(Board, Row, _, Acc) ->
    NextRow = next_row(Board, Row, 0, []),
    game_of_life(Board, Row + 1, length(Board) - 1, [NextRow | Acc]).

next_row(_, _, _, Acc) when Acc /= [] -> lists:reverse(Acc);
next_row(Board, Row, Col, Acc) ->
    Current = lists:nth(Col + 1, lists:nth(Row, Board)),
    Neighbors = count_neighbors(Board, Row, Col),
    NewVal = case {Current, Neighbors} of
        {1, 2} -> 1;
        {1, 3} -> 1;
        {1, _} -> 0;
        {0, 3} -> 1;
        _ -> 0
    end,
    next_row(Board, Row, Col + 1, [NewVal | Acc]).

count_neighbors(Board, Row, Col) ->
    Count = 0,
    count_neighbors(Board, Row, Col, -1, -1, Count).

count_neighbors(_, _, _, 2, 2, Acc) ->
    Acc;
count_neighbors(Board, Row, Col, DRow, DCol, Acc) ->
    if
        DRow == -1 andalso DCol == -1 ->
            count_neighbors(Board, Row, Col, DRow, DCol + 1, Acc);
        DCol == 2 ->
            count_neighbors(Board, Row, Col, DRow + 1, -1, Acc);
        true ->
            NewAcc = if
                is_valid(Board, Row + DRow, Col + DCol) ->
                    if
                        lists:nth(Col + DCol + 1, lists:nth(Row + DRow, Board)) == 1 ->
                            Acc + 1;
                        true ->
                            Acc
                    end;
                true ->
                    Acc
            end,
            count_neighbors(Board, Row, Col, DRow, DCol + 1, NewAcc)
    end.

is_valid(Board, Row, Col) ->
    Row >= 0 andalso Row < length(Board) andalso Col >= 0 andalso Col < length(lists:nth(Row + 1, Board)).