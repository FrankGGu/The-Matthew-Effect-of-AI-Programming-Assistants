-spec solve(Board :: [[char()]]) -> ok.
solve(Board) ->
    case Board of
        [] -> ok;
        _ ->
            Rows = length(Board),
            Cols = length(hd(Board)),
            % Mark border 'O's and connected regions as 'T'
            Mark = fun(I, J) ->
                case (I >= 0) andalso (I < Rows) andalso (J >= 0) andalso (J < Cols) andalso (lists:nth(J + 1, lists:nth(I + 1, Board)) =:= $O) of
                    true ->
                        NewRow = setelement(J + 1, lists:nth(I + 1, Board), $T),
                        NewBoard = setelement(I + 1, Board, NewRow),
                        {NewBoard1, _} = mark_adjacent(NewBoard, I + 1, J + 1, Rows, Cols),
                        NewBoard1;
                    false -> Board
                end
            end,
            % Process borders
            Board1 = lists:foldl(fun(J, Acc) -> Mark(0, J) end, Board, lists:seq(0, Cols - 1)),
            Board2 = lists:foldl(fun(J, Acc) -> Mark(Rows - 1, J) end, Board1, lists:seq(0, Cols - 1)),
            Board3 = lists:foldl(fun(I, Acc) -> Mark(I, 0) end, Board2, lists:seq(0, Rows - 1)),
            FinalBoard = lists:foldl(fun(I, Acc) -> Mark(I, Cols - 1) end, Board3, lists:seq(0, Rows - 1)),
            % Flip remaining 'O's to 'X' and 'T's back to 'O'
            Flip = fun(Row) ->
                lists:map(fun(C) ->
                    case C of
                        $O -> $X;
                        $T -> $O;
                        _ -> C
                    end
                end, tuple_to_list(Row))
            end,
            Flipped = lists:map(Flip, tuple_to_list(FinalBoard)),
            % Convert back to original format and update
            lists:foreach(fun(I) ->
                Row = lists:nth(I + 1, Flipped),
                lists:foreach(fun(J) ->
                    OriginalRow = lists:nth(I + 1, Board),
                    NewRow = setelement(J + 1, OriginalRow, lists:nth(J + 1, Row)),
                    setelement(I + 1, Board, NewRow)
                end, lists:seq(0, Cols - 1))
            end, lists:seq(0, Rows - 1)),
            ok
    end.

mark_adjacent(Board, I, J, Rows, Cols) ->
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    lists:foldl(fun({Di, Dj}, {AccBoard, _}) ->
        NewI = I - 1 + Di,
        NewJ = J - 1 + Dj,
        case (NewI >= 0) andalso (NewI < Rows) andalso (NewJ >= 0) andalso (NewJ < Cols) andalso (element(NewJ + 1, element(NewI + 1, AccBoard)) =:= $O of
            true ->
                NewRow = setelement(NewJ + 1, element(NewI + 1, AccBoard), $T),
                NewBoard = setelement(NewI + 1, AccBoard, NewRow),
                mark_adjacent(NewBoard, NewI + 1, NewJ + 1, Rows, Cols);
            false -> {AccBoard, ok}
        end
    end, {Board, ok}, Directions).