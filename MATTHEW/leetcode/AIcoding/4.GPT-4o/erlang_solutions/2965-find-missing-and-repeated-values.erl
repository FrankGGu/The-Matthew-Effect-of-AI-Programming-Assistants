-module(solution).
-export([find_missing_and_repeating/1]).

find_missing_and_repeating(List) ->
    N = length(List),
    SumN = N * (N + 1) div 2,
    SumList = lists:sum(List),
    SumSquaresN = N * (N + 1) * (2 * N + 1) div 6,
    SumSquaresList = lists:foldl(fun(X, Acc) -> Acc + X * X end, 0, List),
    S1 = SumN - SumList,
    S2 = SumSquaresN - SumSquaresList,
    X = (S2 div S1 + S1) div 2,
    Y = X - S1,
    [Y, X].