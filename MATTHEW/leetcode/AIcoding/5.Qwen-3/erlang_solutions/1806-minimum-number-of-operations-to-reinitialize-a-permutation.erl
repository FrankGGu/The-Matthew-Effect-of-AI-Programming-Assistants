-module(leetcode).
-export([reinitializePermutation/1]).

reinitializePermutation(N) ->
    reinitializePermutation(N, 1, 0).

reinitializePermutation(N, Pos, Count) when Pos == N ->
    Count;
reinitializePermutation(N, Pos, Count) ->
    case Pos rem 2 of
        0 ->
            NewPos = Pos div 2;
        1 ->
            NewPos = (N - 1) - (Pos - 1) div 2
    end,
    reinitializePermutation(N, NewPos, Count + 1).