-spec max_value(Grid :: [[integer()]]) -> integer().
max_value(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    DP = lists:duplicate(M + 1, lists:duplicate(N + 1, 0)),
    UpdatedDP = lists:foldl(fun(I, AccI) ->
        Row = lists:nth(I + 1, Grid),
        lists:foldl(fun(J, AccJ) ->
            Prev = max(lists:nth(J, lists:nth(I, AccJ)), lists:nth(J + 1, lists:nth(I + 1, AccJ))),
            NewVal = Prev + lists:nth(J, Row),
            NewRow = setelement(J + 1, lists:nth(I + 1, AccJ), NewVal),
            setelement(I + 1, AccJ, NewRow)
        end, AccI, lists:seq(1, N))
    end, DP, lists:seq(1, M)),
    lists:nth(N + 1, lists:nth(M + 1, UpdatedDP)).