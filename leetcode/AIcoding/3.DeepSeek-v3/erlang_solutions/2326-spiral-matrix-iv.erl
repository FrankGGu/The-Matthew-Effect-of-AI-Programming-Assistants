-spec spiral_matrix(M :: integer(), N :: integer(), Head :: #list_node{} | null) -> [[integer()]].
spiral_matrix(M, N, Head) ->
    Matrix = lists:duplicate(M, lists:duplicate(N, -1)),
    spiral_matrix(0, 0, M - 1, N - 1, Head, Matrix).

spiral_matrix(RowStart, ColStart, RowEnd, ColEnd, Head, Matrix) when RowStart =< RowEnd andalso ColStart =< ColEnd ->
    {NewMatrix1, NewHead1} = fill_top(RowStart, ColStart, ColEnd, Head, Matrix),
    {NewMatrix2, NewHead2} = fill_right(RowStart + 1, ColEnd, RowEnd, NewHead1, NewMatrix1),
    case RowStart < RowEnd of
        true ->
            {NewMatrix3, NewHead3} = fill_bottom(RowEnd, ColEnd - 1, ColStart, NewHead2, NewMatrix2),
            case ColStart < ColEnd of
                true ->
                    {NewMatrix4, NewHead4} = fill_left(RowEnd - 1, ColStart, RowStart + 1, NewHead3, NewMatrix3),
                    spiral_matrix(RowStart + 1, ColStart + 1, RowEnd - 1, ColEnd - 1, NewHead4, NewMatrix4);
                false ->
                    {NewMatrix3, NewHead3}
            end;
        false ->
            {NewMatrix2, NewHead2}
    end;
spiral_matrix(_, _, _, _, _, Matrix) ->
    Matrix.

fill_top(Row, ColStart, ColEnd, Head, Matrix) ->
    fill_top(Row, ColStart, ColEnd, Head, Matrix, []).

fill_top(Row, Col, ColEnd, Head, Matrix, Acc) when Col =< ColEnd ->
    case Head of
        null ->
            {lists:reverse(Acc) ++ [lists:nth(Row + 1, Matrix)], Head};
        #list_node{val = Val, next = Next} ->
            RowList = lists:nth(Row + 1, Matrix),
            NewRowList = replace_nth(Col + 1, Val, RowList),
            NewMatrix = replace_nth(Row + 1, NewRowList, Matrix),
            fill_top(Row, Col + 1, ColEnd, Next, NewMatrix, [NewRowList | Acc])
    end;
fill_top(Row, _, _, Head, Matrix, Acc) ->
    {lists:reverse(Acc) ++ lists:nthtail(length(Acc), Matrix), Head}.

fill_right(RowStart, Col, RowEnd, Head, Matrix) ->
    fill_right(RowStart, Col, RowEnd, Head, Matrix, []).

fill_right(Row, Col, RowEnd, Head, Matrix, Acc) when Row =< RowEnd ->
    case Head of
        null ->
            {lists:reverse(Acc) ++ Matrix, Head};
        #list_node{val = Val, next = Next} ->
            RowList = lists:nth(Row + 1, Matrix),
            NewRowList = replace_nth(Col + 1, Val, RowList),
            NewMatrix = replace_nth(Row + 1, NewRowList, Matrix),
            fill_right(Row + 1, Col, RowEnd, Next, NewMatrix, [NewRowList | Acc])
    end;
fill_right(_, _, _, Head, Matrix, Acc) ->
    {lists:reverse(Acc) ++ Matrix, Head}.

fill_bottom(Row, ColStart, ColEnd, Head, Matrix) ->
    fill_bottom(Row, ColStart, ColEnd, Head, Matrix, []).

fill_bottom(Row, Col, ColEnd, Head, Matrix, Acc) when Col >= ColEnd ->
    case Head of
        null ->
            {lists:reverse(Acc) ++ [lists:nth(Row + 1, Matrix)], Head};
        #list_node{val = Val, next = Next} ->
            RowList = lists:nth(Row + 1, Matrix),
            NewRowList = replace_nth(Col + 1, Val, RowList),
            NewMatrix = replace_nth(Row + 1, NewRowList, Matrix),
            fill_bottom(Row, Col - 1, ColEnd, Next, NewMatrix, [NewRowList | Acc])
    end;
fill_bottom(Row, _, _, Head, Matrix, Acc) ->
    {lists:reverse(Acc) ++ lists:nthtail(length(Acc), Matrix), Head}.

fill_left(RowStart, Col, RowEnd, Head, Matrix) ->
    fill_left(RowStart, Col, RowEnd, Head, Matrix, []).

fill_left(Row, Col, RowEnd, Head, Matrix, Acc) when Row >= RowEnd ->
    case Head of
        null ->
            {lists:reverse(Acc) ++ Matrix, Head};
        #list_node{val = Val, next = Next} ->
            RowList = lists:nth(Row + 1, Matrix),
            NewRowList = replace_nth(Col + 1, Val, RowList),
            NewMatrix = replace_nth(Row + 1, NewRowList, Matrix),
            fill_left(Row - 1, Col, RowEnd, Next, NewMatrix, [NewRowList | Acc])
    end;
fill_left(_, _, _, Head, Matrix, Acc) ->
    {lists:reverse(Acc) ++ Matrix, Head}.

replace_nth(1, Val, [_ | T]) -> [Val | T];
replace_nth(N, Val, [H | T]) -> [H | replace_nth(N - 1, Val, T)].