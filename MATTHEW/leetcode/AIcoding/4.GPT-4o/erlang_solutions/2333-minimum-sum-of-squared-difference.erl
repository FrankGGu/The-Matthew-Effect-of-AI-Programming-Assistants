-module(solution).
-export([min_sum_squared_diff/2]).

min_sum_squared_diff(A, B) ->
    N = length(A),
    SortedA = lists:sort(A),
    SortedB = lists:sort(B),
    {MinA, MaxA} = lists:split(N div 2, SortedA),
    {MinB, MaxB} = lists:split(N div 2, SortedB),
    MinSum = lists:foldl(fun(X, Acc) -> Acc + (X - hd(MinB)) * (X - hd(MinB)) end, 0, MinA) +
              lists:foldl(fun(X, Acc) -> Acc + (X - hd(MaxB)) * (X - hd(MaxB)) end, 0, MaxA),
    MinSum.