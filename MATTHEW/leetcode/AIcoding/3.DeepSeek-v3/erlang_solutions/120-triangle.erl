-spec minimum_total(Triangle :: [[integer()]]) -> integer().
minimum_total(Triangle) ->
    case Triangle of
        [] -> 0;
        _ ->
            Rows = length(Triangle),
            DP = lists:foldl(fun(Row, Acc) ->
                Len = length(Row),
                lists:map(fun(I) ->
                    case I of
                        0 -> lists:nth(1, Row) + lists:nth(1, Acc);
                        Last when Last == Len - 1 -> lists:nth(Len, Row) + lists:nth(Last, Acc);
                        _ -> lists:nth(I + 1, Row) + min(lists:nth(I, Acc), lists:nth(I + 1, Acc))
                    end
                end, lists:seq(0, Len - 1))
            end, hd(Triangle), tl(Triangle)),
            lists:min(DP)
    end.