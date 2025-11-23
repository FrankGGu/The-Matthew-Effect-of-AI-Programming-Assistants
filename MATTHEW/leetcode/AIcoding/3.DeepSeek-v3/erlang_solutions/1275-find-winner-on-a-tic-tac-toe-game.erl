-spec tictactoe(Moves :: [[integer()]]) -> unicode:unicode_binary().
tictactoe(Moves) ->
    Rows = [[0, 0, 0], [0, 0, 0], [0, 0, 0]],
    Cols = [[0, 0, 0], [0, 0, 0], [0, 0, 0]],
    Diag = [0, 0],
    AntiDiag = [0, 0],
    play(Moves, Rows, Cols, Diag, AntiDiag, 0).

play([], _, _, _, _, _) -> <<"Draw">>;
play([[X, Y] | Rest], Rows, Cols, Diag, AntiDiag, Player) ->
    NewRows = update_row(Rows, X, Y, Player),
    NewCols = update_col(Cols, X, Y, Player),
    {NewDiag, NewAntiDiag} = update_diags(Diag, AntiDiag, X, Y, Player),
    case check_win(NewRows, NewCols, NewDiag, NewAntiDiag, X, Y) of
        true ->
            case Player of
                0 -> <<"A">>;
                1 -> <<"B">>
            end;
        false ->
            play(Rest, NewRows, NewCols, NewDiag, NewAntiDiag, 1 - Player)
    end.

update_row(Rows, X, Y, Player) ->
    Row = lists:nth(X + 1, Rows),
    NewRow = setelement(Y + 1, list_to_tuple(Row), Player + 1),
    setelement(X + 1, list_to_tuple(Rows), tuple_to_list(NewRow)).

update_col(Cols, X, Y, Player) ->
    Col = lists:nth(Y + 1, Cols),
    NewCol = setelement(X + 1, list_to_tuple(Col), Player + 1),
    setelement(Y + 1, list_to_tuple(Cols), tuple_to_list(NewCol)).

update_diags(Diag, AntiDiag, X, Y, Player) ->
    NewDiag = if
        X =:= Y -> setelement(X + 1, list_to_tuple(Diag), Player + 1);
        true -> Diag
    end,
    NewAntiDiag = if
        X + Y =:= 2 -> setelement(X + 1, list_to_tuple(AntiDiag), Player + 1);
        true -> AntiDiag
    end,
    {NewDiag, NewAntiDiag}.

check_win(Rows, Cols, Diag, AntiDiag, X, Y) ->
    Row = lists:nth(X + 1, Rows),
    Col = lists:nth(Y + 1, Cols),
    (lists:all(fun(V) -> V =:= 1 end, Row) orelse lists:all(fun(V) -> V =:= 2 end, Row)) orelse
    (lists:all(fun(V) -> V =:= 1 end, Col) orelse lists:all(fun(V) -> V =:= 2 end, Col)) orelse
    (X =:= Y andalso (lists:all(fun(V) -> V =:= 1 end, Diag) orelse lists:all(fun(V) -> V =:= 2 end, Diag))) orelse
    (X + Y =:= 2 andalso (lists:all(fun(V) -> V =:= 1 end, AntiDiag) orelse lists:all(fun(V) -> V =:= 2 end, AntiDiag))).