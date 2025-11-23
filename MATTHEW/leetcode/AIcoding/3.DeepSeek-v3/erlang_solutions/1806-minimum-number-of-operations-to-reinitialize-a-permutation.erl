-module(solution).
-export([reinitialize_permutation/1]).

reinitialize_permutation(N) ->
    reinitialize_permutation(N, 1, 0, 0).

reinitialize_permutation(N, Pos, Step, Count) when Pos == 0 andalso Step /= 0 ->
    Count;
reinitialize_permutation(N, Pos, Step, Count) ->
    NewPos = if
        Pos rem 2 == 0 -> Pos div 2;
        true -> (N div 2) + ((Pos - 1) div 2)
    end,
    reinitialize_permutation(N, NewPos, Step + 1, Count + 1).