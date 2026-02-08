-spec count_battleships(Board :: [[char()]]) -> integer().
count_battleships(Board) ->
    Rows = length(Board),
    case Rows of
        0 -> 0;
        _ ->
            Cols = length(hd(Board)),
            count(Board, Rows, Cols, 0, 0, 0)
    end.

count(Board, Rows, Cols, I, J, Acc) when I < Rows ->
    case J < Cols of
        true ->
            case lists:nth(J + 1, lists:nth(I + 1, Board)) of
                $X ->
                    case (I =:= 0 orelse lists:nth(J + 1, lists:nth(I, Board)) =/= $X) andalso
                         (J =:= 0 orelse lists:nth(J, lists:nth(I + 1, Board)) =/= $X) of
                        true ->
                            count(Board, Rows, Cols, I, J + 1, Acc + 1);
                        false ->
                            count(Board, Rows, Cols, I, J + 1, Acc)
                    end;
                _ ->
                    count(Board, Rows, Cols, I, J + 1, Acc)
            end;
        false ->
            count(Board, Rows, Cols, I + 1, 0, Acc)
    end;
count(_, _, _, _, _, Acc) ->
    Acc.