-module(solution).
-export([max_sum_two_no_overlap/2]).

max_sum_two_no_overlap(A, L, M) ->
    MaxL = lists:foldl(fun(X, Acc) -> max(Acc, X) end, 0, lists:map(fun({Sum, _}) -> Sum end, window_sums(A, L))),
    MaxM = lists:foldl(fun(X, Acc) -> max(Acc, X) end, 0, lists:map(fun({_, Sum}) -> Sum end, window_sums(A, M))),
    max_sum(A, L, M, MaxL, MaxM).

max_sum([], _, _, _, _) -> 0;
max_sum(A, L, M, MaxL, MaxM) ->
    MaxS = lists:foldl(fun(X, Acc) -> max(Acc, X) end, 0, 
        lists:map(fun({Lsum, Msum}) -> Lsum + Msum end, lists:zip(window_sums(A, L), window_sums(tl(A), M)))) + MaxL,
    MaxS.

window_sums([], _) -> [];
window_sums(List, Size) ->
    {Sum, _} = lists:foldl(fun(X, {S, L}) -> {S + X, [X | L]} end, {0, []}, lists:take(Size, List)),
    [Sum | window_sums(tl(List), Size)].