-module(solution).
-export([spiral_matrix/3]).

spiral_matrix(R, C, K) ->
    spiral_matrix(0, 0, R, C, K, [[0, 0]]).

spiral_matrix(X, Y, R, C, K, Acc) when length(Acc) < K ->
    NewAcc = case {X rem 2, Y rem 2} of
        {0, 0} -> lists:append(Acc, [[X, Y]]);
        {1, 0} -> lists:append(Acc, [[X, Y + 1]]);
        {0, 1} -> lists:append(Acc, [[X + 1, Y]]);
        {1, 1} -> lists:append(Acc, [[X, Y - 1]]);
    end,
    Next = case {X, Y} of
        {0, C - 1} -> {X + 1, Y};
        {R - 1, C - 1} -> {X, Y - 1};
        {R - 1, 0} -> {X - 1, Y};
        {0, 0} -> {X, Y + 1};
        _ -> {X + 1, Y}
    end,
    spiral_matrix(fst(Next), snd(Next), R, C, K, NewAcc);
spiral_matrix(_, _, _, _, _, Acc) -> Acc.

fst({X, _}) -> X.
snd({_, Y}) -> Y.