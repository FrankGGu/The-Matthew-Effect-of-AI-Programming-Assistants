-spec zigzag_traverse_with_skip(Matrix :: [[integer()]], Skip :: integer()) -> [integer()].
zigzag_traverse_with_skip(Matrix, Skip) ->
    case Matrix of
        [] -> [];
        _ ->
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            traverse(Matrix, 0, 0, Rows, Cols, Skip, [], false)
    end.

traverse(Matrix, Row, Col, Rows, Cols, Skip, Acc, IsUp) ->
    if
        Row >= Rows orelse Col >= Cols orelse Row < 0 orelse Col < 0 ->
            lists:reverse(Acc);
        true ->
            Value = lists:nth(Col + 1, lists:nth(Row + 1, Matrix)),
            NewAcc = if
                Value =:= Skip -> Acc;
                true -> [Value | Acc]
            end,
            if
                IsUp ->
                    if
                        Col =:= Cols - 1 ->
                            traverse(Matrix, Row + 1, Col, Rows, Cols, Skip, NewAcc, false);
                        Row =:= 0 ->
                            traverse(Matrix, Row, Col + 1, Rows, Cols, Skip, NewAcc, false);
                        true ->
                            traverse(Matrix, Row - 1, Col + 1, Rows, Cols, Skip, NewAcc, true)
                    end;
                true ->
                    if
                        Row =:= Rows - 1 ->
                            traverse(Matrix, Row, Col + 1, Rows, Cols, Skip, NewAcc, true);
                        Col =:= 0 ->
                            traverse(Matrix, Row + 1, Col, Rows, Cols, Skip, NewAcc, true);
                        true ->
                            traverse(Matrix, Row + 1, Col - 1, Rows, Cols, Skip, NewAcc, false)
                    end
            end
    end.