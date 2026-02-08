-module(solution).
-export([diagonal_sum/1]).

diagonal_sum(Matrix) ->
    N = length(Matrix),
    sum_diagonals_recursive(Matrix, Matrix, N, 0, 0).

sum_diagonals_recursive(OriginalMatrix, [CurrentRow | RestRows], N, I, AccSum) when I < N ->
    PrimaryElement = lists:nth(I + 1, CurrentRow),
    SecondaryElement = lists:nth(N - I, CurrentRow),
    NewAccSum = AccSum + PrimaryElement + SecondaryElement,
    sum_diagonals_recursive(OriginalMatrix, RestRows, N, I + 1, NewAccSum);
sum_diagonals_recursive(OriginalMatrix, [], N, _I, AccSum) ->
    if N rem 2 == 1 ->
        CenterIndex = N div 2,
        CenterRow = lists:nth(CenterIndex + 1, OriginalMatrix),
        CenterElement = lists:nth(CenterIndex + 1, CenterRow),
        AccSum - CenterElement;
    true ->
        AccSum
    end.