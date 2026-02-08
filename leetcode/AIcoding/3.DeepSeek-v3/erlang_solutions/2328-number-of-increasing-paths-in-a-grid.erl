-module(solution).
-export([count_paths/1]).

count_paths(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    DP = lists:duplicate(M, lists:duplicate(N, 1)),
    Coords = lists:sort(
        fun({I1, J1}, {I2, J2}) ->
            (lists:nth(J1 + 1, lists:nth(I1 + 1, Grid))) =<
            (lists:nth(J2 + 1, lists:nth(I2 + 1, Grid)))
        end,
        [{I, J} || I <- lists:seq(0, M - 1), J <- lists:seq(0, N - 1)]
    ),
    lists:foldl(
        fun({I, J}, Acc) ->
            Val = lists:nth(J + 1, lists:nth(I + 1, Grid)),
            Neighbors = [
                {I - 1, J} || I > 0, lists:nth(J + 1, lists:nth(I, Grid)) < Val,
                {I + 1, J} || I < M - 1, lists:nth(J + 1, lists:nth(I + 2, Grid)) < Val,
                {I, J - 1} || J > 0, lists:nth(J, lists:nth(I + 1, Grid)) < Val,
                {I, J + 1} || J < N - 1, lists:nth(J + 2, lists:nth(I + 1, Grid)) < Val
            ],
            NewDP = lists:foldl(
                fun({X, Y}, DPAcc) ->
                    Row = lists:nth(X + 1, DPAcc),
                    UpdatedRow = lists:sublist(Row, Y + 1) ++
                                [lists:nth(Y + 1, Row) + lists:nth(J + 1, lists:nth(I + 1, Acc))] ++
                                lists:nthtail(Y + 2, Row),
                    lists:sublist(DPAcc, X + 1) ++ [UpdatedRow] ++ lists:nthtail(X + 2, DPAcc)
                end,
                Acc,
                Neighbors
            ),
            NewDP
        end,
        DP,
        Coords
    ),
    Sum = lists:sum([lists:sum(Row) || Row <- DP]),
    Sum rem 1000000007.