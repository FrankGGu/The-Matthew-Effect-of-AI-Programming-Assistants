-module(solution).
-export([minimumOperations/1]).

get_column_counts(Grid, M, N) ->
    InitialCounts = lists:duplicate(N, lists:duplicate(10, 0)),
    lists:foldl(
        fun(Row, AccCounts) ->
            lists:foldl(
                fun({Val, ColIdx}, AccCountsInner) ->
                    ColCounts = lists:nth(ColIdx + 1, AccCountsInner),
                    CurrentValCount = lists:nth(Val + 1, ColCounts),
                    NewColCounts = lists:replace_nth(Val + 1, CurrentValCount + 1, ColCounts),
                    lists:replace_nth(ColIdx + 1, NewColCounts, AccCountsInner)
                end,
                AccCounts,
                lists:zip(Row, lists:seq(0, N-1))
            )
        end,
        InitialCounts,
        Grid
    ).

minimumOperations(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),

    ColumnCounts = get_column_counts(Grid, M, N),

    Col0Counts = lists:nth(1, ColumnCounts),
    dp_prev = [M - lists:nth(Val + 1, Col0Counts) || Val <- lists:seq(0, 9)],

    FinalDPValues = lists:foldl(
        fun(J, AccDPPrev) ->
            ColJCounts = lists:nth(J + 1, ColumnCounts),

            NewDPCurrent = lists:map(
                fun(Val) ->
                    CurrentColCost = M - lists:nth(Val + 1, ColJCounts),

                    MinPrevDP = lists:foldl(
                        fun(PrevVal, AccMin) ->
                            if PrevVal == Val -> AccMin;
                               true -> min(AccMin, lists:nth(PrevVal + 1, AccDPPrev))
                            end
                        end,
                        2001,
                        lists:seq(0, 9)
                    ),
                    CurrentColCost + MinPrevDP
                end,
                lists:seq(0, 9)
            ),
            NewDPCurrent
        end,
        dp_prev,
        lists:seq(1, N-1)
    ),

    lists:min(FinalDPValues).