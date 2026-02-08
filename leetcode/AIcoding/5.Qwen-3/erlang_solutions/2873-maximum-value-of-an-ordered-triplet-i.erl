-module(solution).
-export([maximum_triplet/1]).

maximum_triplet(Numbers) ->
    maximum_triplet(Numbers, 0, 0, 0).

maximum_triplet([], _A, _B, _C) ->
    0;
maximum_triplet([N | Rest], A, B, C) ->
    NewA = max(A, N),
    NewB = max(B, N * A),
    NewC = max(C, N * B),
    maximum_triplet(Rest, NewA, NewB, NewC).