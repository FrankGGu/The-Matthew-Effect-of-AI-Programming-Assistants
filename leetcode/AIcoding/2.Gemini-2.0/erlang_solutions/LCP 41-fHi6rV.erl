-module(flipChess).
-export([flipChess/1]).

flipChess(chessboard) ->
    Rows = length(chessboard),
    Cols = length(hd(chessboard)),
    MaxFlip = 0,
    for(I = 0, I < Rows, I++),
        for(J = 0, J < Cols, J++),
            if lists:nth(J+1, lists:nth(I+1, chessboard)) == '.',
                NumFlip = simulate_flip(chessboard, I, J, Rows, Cols),
                MaxFlip = max(MaxFlip, NumFlip)
            end
        end
    end,
    MaxFlip.

simulate_flip(Chessboard, Row, Col, Rows, Cols) ->
    UpdatedBoard = lists:map(fun(L) -> L end, Chessboard),
    UpdatedBoard1 = lists:nth(Row+1, UpdatedBoard),
    lists:nth(Row+1, UpdatedBoard) ! lists:set_nth(Col+1, UpdatedBoard1, 'x'),

    FlipCount = flip_recursive(UpdatedBoard, Row, Col, Rows, Cols, 0),
    FlipCount.

flip_recursive(Board, Row, Col, Rows, Cols, Acc) ->
    Neighbors = get_neighbors(Row, Col, Rows, Cols),

    lists:foldl(fun({Nr, Nc}, Acc1) ->
        case should_flip(Board, Row, Col, Nr, Nc) of
            true ->
                NewBoard = flip_between(Board, Row, Col, Nr, Nc, Rows, Cols),
                flip_recursive(NewBoard, Row, Col, Rows, Cols, Acc1 + num_flips(Board, NewBoard));
            false ->
                Acc1
        end
    end, Acc, Neighbors).

num_flips(OldBoard, NewBoard) ->
    Rows = length(OldBoard),
    Cols = length(hd(OldBoard)),
    count_flips(OldBoard, NewBoard, Rows, Cols, 0, 0, 0).

count_flips(OldBoard, NewBoard, Rows, Cols, Row, Col, Count) ->
    if Row >= Rows then
        Count
    else
        OldVal = lists:nth(Col+1, lists:nth(Row+1, OldBoard)),
        NewVal = lists:nth(Col+1, lists:nth(Row+1, NewBoard)),

        NewCount = if OldVal /= NewVal,
                       Count + 1,
                   otherwise,
                       Count
                   end,

        if Col + 1 < Cols then
            count_flips(OldBoard, NewBoard, Rows, Cols, Row, Col + 1, NewCount)
        else
            count_flips(OldBoard, NewBoard, Rows, Cols, Row + 1, 0, NewCount)
        end
    end.

flip_between(Board, Row, Col, Nr, Nc, Rows, Cols) ->

    Dx = sign(Nr - Row),
    Dy = sign(Nc - Col),

    flip_along_line(Board, Row, Col, Dx, Dy, Nr, Nc, Rows, Cols).

flip_along_line(Board, Row, Col, Dx, Dy, Nr, Nc, Rows, Cols) ->
    flip_along_line_helper(Board, Row, Col, Dx, Dy, Nr, Nc, Rows, Cols, []).

flip_along_line_helper(Board, Row, Col, Dx, Dy, Nr, Nc, Rows, Cols, Acc) ->
    if Row == Nr and Col == Nc then
        flip_cells(Board, lists:reverse(Acc))
    else
        flip_along_line_helper(Board, Row + Dx, Col + Dy, Dx, Dy, Nr, Nc, Rows, Cols, [{Row + Dx, Col + Dy} | Acc])
    end.

flip_cells(Board, Cells) ->
    lists:foldl(fun({R, C}, B) ->
        flip_cell(B, R, C)
    end, Board, Cells).

flip_cell(Board, Row, Col) ->
    NewBoard = lists:map(fun(L) -> L end, Board),
    NewBoard1 = lists:nth(Row+1, NewBoard),

    Val = lists:nth(Col+1, lists:nth(Row+1, Board)),

    NewVal = case Val of
        'x' -> 'o';
        'o' -> 'x';
        _ -> Val
    end,

    lists:nth(Row+1, NewBoard) ! lists:set_nth(Col+1, NewBoard1, NewVal),

    NewBoard.

sign(X) ->
    if X > 0 then 1
    else if X < 0 then -1
    else 0
    end.

should_flip(Board, Row, Col, Nr, Nc) ->
    Val = lists:nth(Col+1, lists:nth(Row+1, Board)),
    NVal = lists:nth(Nc+1, lists:nth(Nr+1, Board)),

    if Val == 'x' and NVal == 'o' then
        can_reach_end(Board, Row, Col, Nr, Nc)
    else
        false
    end.

can_reach_end(Board, Row, Col, Nr, Nc) ->
    Dx = sign(Nr - Row),
    Dy = sign(Nc - Col),

    can_reach_end_helper(Board, Nr, Nc, Dx, Dy, lists:nth(Col+1, lists:nth(Row+1, Board))).

can_reach_end_helper(Board, Row, Col, Dx, Dy, Original) ->
    try
        Val = lists:nth(Col+1, lists:nth(Row+1, Board)),
        if Val == Original then
            true
        else if Val == '.' then
            false
        else
            can_reach_end_helper(Board, Row + Dx, Col + Dy, Dx, Dy, Original)
        end
    catch
        _:_ -> false
    end.

get_neighbors(Row, Col, Rows, Cols) ->
    Neighbors = [],

    add_neighbor(Row - 1, Col - 1, Rows, Cols, Neighbors, Acc1),
    add_neighbor(Row - 1, Col, Rows, Cols, Acc1, Acc2),
    add_neighbor(Row - 1, Col + 1, Rows, Cols, Acc2, Acc3),
    add_neighbor(Row, Col - 1, Rows, Cols, Acc3, Acc4),
    add_neighbor(Row, Col + 1, Rows, Cols, Acc4, Acc5),
    add_neighbor(Row + 1, Col - 1, Rows, Cols, Acc5, Acc6),
    add_neighbor(Row + 1, Col, Rows, Cols, Acc6, Acc7),
    add_neighbor(Row + 1, Col + 1, Rows, Cols, Acc7, Neighbors).

add_neighbor(Row, Col, Rows, Cols, AccIn, AccOut) ->
    if Row >= 0 and Row < Rows and Col >= 0 and Col < Cols then
        AccOut = [{Row, Col} | AccIn]
    else
        AccOut = AccIn
    end.