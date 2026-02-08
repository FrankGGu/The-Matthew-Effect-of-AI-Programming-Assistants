-spec num_ways(N :: integer()) -> integer().
num_ways(N) ->
    case N of
        0 -> 1;
        1 -> 1;
        2 -> 2;
        _ ->
            DP = lists:seq(1, N),
            DP1 = setelement(1, DP, 1),
            DP2 = setelement(2, DP1, 2),
            lists:foldl(fun(I, Acc) ->
                Prev1 = element(I - 1, Acc),
                Prev2 = element(I - 2, Acc),
                setelement(I, Acc, (Prev1 + Prev2) rem 1000000007)
            end, DP2, lists:seq(3, N)),
            element(N, DP2)
    end.