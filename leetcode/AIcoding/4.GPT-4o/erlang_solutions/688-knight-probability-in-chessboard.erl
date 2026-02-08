-module(knight_probability).
-export([knightProbability/3]).

knightProbability(N, K, r) ->
    case K of 
        0 -> 1.0; 
        _ -> 
            Sum = knightProbabilityHelper(N, K, r, 0),
            Sum / (8.0 ^ K)
    end.

knightProbabilityHelper(_, 0, _, _) -> 1.0;
knightProbabilityHelper(N, K, r, c) ->
    case {r < 0, r >= N, c < 0, c >= N} of
        {true, _, _, _} -> 0.0;
        {_, true, _, _} -> 0.0;
        {_, _, true, _} -> 0.0;
        {_, _, _, true} -> 0.0;
        _ ->
            knightProbabilityHelper(N, K - 1, r + 2, c + 1) +
            knightProbabilityHelper(N, K - 1, r + 2, c - 1) +
            knightProbabilityHelper(N, K - 1, r - 2, c + 1) +
            knightProbabilityHelper(N, K - 1, r - 2, c - 1) +
            knightProbabilityHelper(N, K - 1, r + 1, c + 2) +
            knightProbabilityHelper(N, K - 1, r + 1, c - 2) +
            knightProbabilityHelper(N, K - 1, r - 1, c + 2) +
            knightProbabilityHelper(N, K - 1, r - 1, c - 2)
    end.