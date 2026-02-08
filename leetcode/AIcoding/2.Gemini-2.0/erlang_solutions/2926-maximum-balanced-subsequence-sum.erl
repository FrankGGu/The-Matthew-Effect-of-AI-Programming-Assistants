-module(maximum_balanced_subsequence_sum).
-export([max_balanced_subsequence_sum/1]).

max_balanced_subsequence_sum(Nums) ->
    max_balanced_subsequence_sum(Nums, 0, 0).

max_balanced_subsequence_sum([], _, MaxSum) ->
    MaxSum;
max_balanced_subsequence_sum([H|T], Index, MaxSum) ->
    Diff = H - Index,
    case Diff of
        _ when Diff < 0 ->
            max_balanced_subsequence_sum(T, Index + 1, MaxSum);
        _ ->
            With = max_balanced_subsequence_sum(T, Index + 1, MaxSum + H),
            Without = max_balanced_subsequence_sum(T, Index + 1, MaxSum),
            max(With, Without)
    end.

max(A, B) ->
    if A > B -> A; true -> B end.