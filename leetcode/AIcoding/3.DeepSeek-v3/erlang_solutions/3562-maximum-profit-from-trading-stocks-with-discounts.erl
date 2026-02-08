-module(solution).
-export([max_profit/3]).

max_profit(Present, Future, Budget) ->
    N = length(Present),
    DP = lists:duplicate(Budget + 1, 0),
    lists:foldl(
        fun(I, Acc) ->
            lists:foldl(
                fun(B, DPAcc) ->
                    if
                        B >= PresentI ->
                            Profit = lists:nth(I + 1, Future) - lists:nth(I + 1, Present),
                            Max = max(lists:nth(B - PresentI + 1, DPAcc) + Profit, lists:nth(B + 1, DPAcc)),
                            setelement(B + 1, DPAcc, Max);
                        true ->
                            DPAcc
                    end
                end,
                Acc,
                lists:seq(Budget, 0, -1)
            )
        end,
        list_to_tuple(DP),
        lists:seq(0, N - 1)
    ),
    element(Budget + 1, lists:foldl(
        fun(I, Acc) ->
            lists:foldl(
                fun(B, DPAcc) ->
                    if
                        B >= PresentI ->
                            Profit = lists:nth(I + 1, Future) - lists:nth(I + 1, Present),
                            Max = max(lists:nth(B - PresentI + 1, DPAcc) + Profit, lists:nth(B + 1, DPAcc)),
                            setelement(B + 1, DPAcc, Max);
                        true ->
                            DPAcc
                    end
                end,
                Acc,
                lists:seq(Budget, 0, -1)
            )
        end,
        list_to_tuple(DP),
        lists:seq(0, N - 1)
    )).