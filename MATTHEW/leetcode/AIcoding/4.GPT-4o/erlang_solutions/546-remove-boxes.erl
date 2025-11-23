-module(solution).
-export([removeBoxes/1]).

removeBoxes(Boxes) ->
    N = length(Boxes),
    M = lists:duplicate(N + 1, lists:duplicate(N + 1, lists:duplicate(N + 1, -1))),
    removeBoxesHelper(Boxes, 0, 0, N, M).

removeBoxesHelper(Boxes, L, K, N, M) ->
    if
        L == N -> 0;
        M[L][K] /= -1 -> M[L][K];
        true ->
            NewL = L,
            NewK = K,
            while (NewL < N andalso (NewL == L orelse Boxes[NewL] == Boxes[L])) NewL = NewL + 1,
            Score = (K + 1) * (K + 1) + removeBoxesHelper(Boxes, NewL, 0, N, M),
            MaxScore = lists:max([Score | lists:map(fun K1 -> removeBoxesHelper(Boxes, NewL, K1 + 1, N, M) end, lists:seq(0, K)])),
            M[L][K] = MaxScore
    end,
    M[L][K].