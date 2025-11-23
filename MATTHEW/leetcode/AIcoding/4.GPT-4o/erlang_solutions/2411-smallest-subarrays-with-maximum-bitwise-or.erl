-module(solution).
-export([smallest_subarrays/1]).

smallest_subarrays(A) ->
    N = length(A),
    MaxOR = lists:foldl(fun(X, Acc) -> bor(X, Acc) end, 0, A),
    lists:map(fun(X) -> smallest_subarray(A, X, MaxOR, N) end, A).

smallest_subarray(A, X, MaxOR, N) ->
    {L, R} = smallest(A, X, MaxOR, 0, 0, N, 0),
    if L > 0 -> R - L + 1; true -> N end.

smallest(A, X, MaxOR, L, R, N, Acc) ->
    if 
        R >= N -> {L, R};
        bor(Acc, lists:nth(R + 1, A)) == MaxOR ->
            smallest(A, X, MaxOR, L + 1, R + 1, N, bor(Acc, lists:nth(R + 1, A)));
        true -> smallest(A, X, MaxOR, L, R + 1, N, Acc)
    end.