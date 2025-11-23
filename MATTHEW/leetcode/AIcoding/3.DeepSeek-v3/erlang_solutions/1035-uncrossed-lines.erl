-spec max_uncrossed_lines(Nums1 :: [integer()], Nums2 :: [integer()]) -> integer().
max_uncrossed_lines(Nums1, Nums2) ->
    M = length(Nums1),
    N = length(Nums2),
    DP = lists:duplicate(M + 1, lists:duplicate(N + 1, 0)),
    solve(Nums1, Nums2, M, N, DP).

solve(Nums1, Nums2, M, N, DP) ->
    lists:foldl(fun(I, DpAccI) ->
        lists:foldl(fun(J, DpAccJ) ->
            case I > 0 andalso J > 0 of
                true ->
                    case lists:nth(I, Nums1) =:= lists:nth(J, Nums2) of
                        true ->
                            Prev = lists:nth(I, lists:nth(J, DpAccJ)),
                            NewVal = lists:nth(I, lists:nth(J, DpAccJ)) + 1,
                            set_value(I + 1, J + 1, NewVal, DpAccJ);
                        false ->
                            Up = lists:nth(I + 1, lists:nth(J, DpAccJ)),
                            Left = lists:nth(I, lists:nth(J + 1, DpAccJ)),
                            Max = max(Up, Left),
                            set_value(I + 1, J + 1, Max, DpAccJ)
                    end;
                false ->
                    DpAccJ
            end
        end, DpAccI, lists:seq(1, N))
    end, DP, lists:seq(1, M)),
    lists:nth(M + 1, lists:nth(N + 1, DP)).

set_value(Row, Col, Value, DP) ->
    RowList = lists:nth(Row, DP),
    NewRowList = set_nth(Col, Value, RowList),
    set_nth(Row, NewRowList, DP).

set_nth(1, Value, [_|T]) -> [Value|T];
set_nth(N, Value, [H|T]) -> [H|set_nth(N - 1, Value, T)].