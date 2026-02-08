-module(solution).
-export([max_value_sum/1]).

max_value_sum(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),

    if M < 3; N < 3 ->
        0;
    true ->
        RowSums = [lists:sum(Row) || Row <- Grid],

        ColSums = lists:foldl(fun(Row, Acc) ->
                                    lists:zipwith(fun(Val, ColSum) -> Val + ColSum end, Row, Acc)
                            end,
                            lists:duplicate(N, 0),
                            Grid),

        Combinations = fun
            Comb(0, _, Acc) -> [lists:reverse(Acc)];
            Comb(K, [H|T], Acc) -> Comb(K-1, T, [H|Acc]) ++ Comb(K, T, Acc);
            Comb(_, [], _) -> []
        end,

        RowIndices = lists:seq(0, M-1),
        RowCombinations = Combinations(3, RowIndices, []),

        MaxTotalSum = lists:foldl(fun(RIndices, CurrentMax) ->
            [R1, R2, R3] = RIndices,

            CurrentRowSum = lists:nth(R1+1, RowSums) + lists:nth(R2+1, RowSums) + lists:nth(R3+1, RowSums),

            ColContributions = lists:seq(0, N-1),
            EffectiveColValues = [
                lists:nth(C+1, ColSums) - lists:nth(C+1, lists:nth(R1+1, Grid)) - lists:nth(C+1, lists:nth(R2+1, Grid)) - lists:nth(C+1, lists:nth(R3+1, Grid))
                || C <- ColContributions
            ],

            SortedColValues = lists:sort(fun(A, B) -> A >= B end, EffectiveColValues),

            Top3ColValues = lists:sublist(SortedColValues, 3),

            CurrentColSumContribution = lists:sum(Top3ColValues),

            TotalSumForThisRowCombo = CurrentRowSum + CurrentColSumContribution,

            max(CurrentMax, TotalSumForThisRowCombo)
        end,
        0,
        RowCombinations),

        MaxTotalSum
    end.