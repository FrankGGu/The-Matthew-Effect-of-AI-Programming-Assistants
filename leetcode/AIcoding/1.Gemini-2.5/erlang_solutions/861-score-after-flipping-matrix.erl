-module(solution).
-export([score_after_flipping_matrix/1]).

score_after_flipping_matrix(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),

    FlippedRowsGrid = lists:map(fun(Row) ->
                                        if hd(Row) == 0 then
                                            [1 - X || X <- Row]
                                        else
                                            Row
                                        end
                                end, Grid),

    calculate_score(FlippedRowsGrid, M, N, 0, 0).

calculate_score(_FlippedRowsGrid, _M, N, ColIdx, CurrentScore) when ColIdx >= N ->
    CurrentScore;
calculate_score(FlippedRowsGrid, M, N, ColIdx, CurrentScore) ->
    ColumnValues = [lists:nth(ColIdx + 1, Row) || Row <- FlippedRowsGrid],

    Ones = lists:sum(ColumnValues),
    Zeros = M - Ones,

    EffectiveOnes = max(Ones, Zeros),

    Weight = 1 bsl (N - 1 - ColIdx),

    NewScore = CurrentScore + EffectiveOnes * Weight,

    calculate_score(FlippedRowsGrid, M, N, ColIdx + 1, NewScore).