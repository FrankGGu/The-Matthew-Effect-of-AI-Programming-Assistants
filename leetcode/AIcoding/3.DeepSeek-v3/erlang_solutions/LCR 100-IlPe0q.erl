-spec minimum_total(Triangle :: [[integer()]]) -> integer().
minimum_total(Triangle) ->
    case Triangle of
        [] -> 0;
        _ ->
            Rows = length(Triangle),
            DP = lists:foldl(fun(Row, Acc) ->
                CurrentLen = length(Row),
                lists:map(fun(I) ->
                    case I of
                        0 -> 
                            lists:nth(1, Row) + lists:nth(1, Acc);
                        Last when Last == CurrentLen - 1 ->
                            lists:nth(CurrentLen, Row) + lists:nth(CurrentLen - 1, Acc);
                        _ ->
                            lists:nth(I + 1, Row) + min(lists:nth(I, Acc), lists:nth(I + 1, Acc))
                    end
                end, lists:seq(0, CurrentLen - 1))
            end, hd(Triangle), tl(Triangle)),
            lists:min(DP)
    end.