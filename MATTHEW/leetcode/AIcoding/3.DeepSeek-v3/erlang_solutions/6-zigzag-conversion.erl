-spec convert(S :: unicode:unicode_binary(), NumRows :: integer()) -> unicode:unicode_binary().
convert(S, NumRows) ->
    case NumRows =:= 1 of
        true -> S;
        false ->
            Rows = lists:duplicate(NumRows, []),
            {_, NewRows} = lists:foldl(fun(Char, {Row, Dir, RowsAcc}) ->
                NewRow = Row + Dir,
                NewRowsAcc = update_row(RowsAcc, Row, Char),
                case (NewRow =:= NumRows - 1) orelse (NewRow =:= 0) of
                    true -> {NewRow, -Dir, NewRowsAcc};
                    false -> {NewRow, Dir, NewRowsAcc}
                end
            end, {0, 1, Rows}, S),
            lists:append(lists:reverse(NewRows))
    end.

update_row(Rows, Index, Char) ->
    {Before, [Row | After]} = lists:split(Index, Rows),
    Before ++ [[Char | Row] | After].