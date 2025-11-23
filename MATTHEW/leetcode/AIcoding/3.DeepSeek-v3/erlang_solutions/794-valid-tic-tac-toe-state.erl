-spec valid_tic_tac_toe(Board :: [unicode:unicode_binary()]) -> boolean().
valid_tic_tac_toe(Board) ->
    Xs = count($X, Board),
    Os = count($O, Board),
    Xwin = is_win($X, Board),
    Owin = is_win($O, Board),
    if
        Xs < Os -> false;
        Xs > Os + 1 -> false;
        Xwin andalso Owin -> false;
        Xwin andalso Xs =:= Os -> false;
        Owin andalso Xs > Os -> false;
        true -> true
    end.

count(Char, Board) ->
    lists:foldl(fun(Row, Acc) ->
        Acc + lists:foldl(fun(C, Sum) -> if C =:= Char -> Sum + 1; true -> Sum end end, 0, binary_to_list(Row))
    end, 0, Board).

is_win(Char, Board) ->
    Rows = [binary_to_list(Row) || Row <- Board],
    Cols = [[lists:nth(I, Row) || Row <- Rows] || I <- lists:seq(1, 3)],
    Diag1 = [lists:nth(I, lists:nth(I, Rows)) || I <- lists:seq(1, 3)],
    Diag2 = [lists:nth(4 - I, lists:nth(I, Rows)) || I <- lists:seq(1, 3)],
    Lines = Rows ++ Cols ++ [Diag1, Diag2],
    lists:any(fun(Line) -> lists:all(fun(C) -> C =:= Char end, Line) end, Lines).