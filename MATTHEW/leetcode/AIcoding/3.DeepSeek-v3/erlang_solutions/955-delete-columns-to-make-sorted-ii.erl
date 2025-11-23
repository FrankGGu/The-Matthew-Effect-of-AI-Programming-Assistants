-spec min_deletion_size(Strs :: [unicode:unicode_binary()]) -> integer().
min_deletion_size(Strs) ->
    case Strs of
        [] -> 0;
        _ ->
            Rows = length(Strs),
            Cols = byte_size(hd(Strs)),
            Deletions = 0,
            Sorted = lists:duplicate(Rows, true),
            min_deletion(Strs, 0, Cols, Rows, Deletions, Sorted)
    end.

min_deletion(_, Col, Cols, _, Deletions, _) when Col >= Cols ->
    Deletions;
min_deletion(Strs, Col, Cols, Rows, Deletions, Sorted) ->
    NeedDelete = false,
    {NewSorted, NeedDelete1} = check_column(Strs, Col, 1, Rows, Sorted, NeedDelete),
    case NeedDelete1 of
        true ->
            min_deletion(Strs, Col + 1, Cols, Rows, Deletions + 1, Sorted);
        false ->
            min_deletion(Strs, Col + 1, Cols, Rows, Deletions, NewSorted)
    end.

check_column(_, _, Row, Rows, Sorted, NeedDelete) when Row >= Rows ->
    {Sorted, NeedDelete};
check_column(Strs, Col, Row, Rows, Sorted, NeedDelete) ->
    case lists:nth(Row, Sorted) of
        false ->
            check_column(Strs, Col, Row + 1, Rows, Sorted, NeedDelete);
        true ->
            Current = binary:at(lists:nth(Row, Strs), Col),
            Prev = binary:at(lists:nth(Row - 1, Strs), Col),
            if
                Current < Prev ->
                    {lists:sublist(Sorted, Row - 1) ++ [false | lists:nthtail(Row, Sorted)], true};
                Current > Prev ->
                    check_column(Strs, Col, Row + 1, Rows, Sorted, NeedDelete);
                true ->
                    check_column(Strs, Col, Row + 1, Rows, Sorted, NeedDelete)
            end
    end.