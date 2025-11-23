-spec min_deletion_size(Strs :: [unicode:unicode_binary()]) -> integer().
min_deletion_size(Strs) ->
    case Strs of
        [] -> 0;
        _ ->
            RowLen = length(Strs),
            ColLen = byte_size(hd(Strs)),
            lists:foldl(
                fun(Col, Acc) ->
                    case is_column_sorted(Strs, Col, RowLen) of
                        true -> Acc;
                        false -> Acc + 1
                    end
                end,
                0,
                lists:seq(0, ColLen - 1)
            )
    end.

is_column_sorted(Strs, Col, RowLen) ->
    lists:all(
        fun(Row) ->
            case Row + 1 of
                NextRow when NextRow < RowLen ->
                    binary:at(lists:nth(NextRow, Strs), Col) >= binary:at(lists:nth(Row, Strs), Col);
                _ ->
                    true
            end
        end,
        lists:seq(0, RowLen - 2)
    ).