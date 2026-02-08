-module(min_diff_sums).
-export([minimumDifference/1]).

minimumDifference(S) ->
    N = length(S),
    K = N div 2,
    Sorted = lists:sort(S),
    Left = lists:sublist(Sorted, K),
    Right = lists:sublist(Sorted, K + 1, N - K),
    SumLeft = lists:sum(Left),
    SumRight = lists:sum(Right),
    SumRight - SumLeft.