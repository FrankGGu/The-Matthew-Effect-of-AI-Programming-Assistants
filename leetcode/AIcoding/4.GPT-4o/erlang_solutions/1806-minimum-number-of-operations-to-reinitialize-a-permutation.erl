-module(solution).
-export([reinitialize_permutation/1]).

reinitialize_permutation(N) ->
    reinitialize_permutation(N, 0, 1).

reinitialize_permutation(N, Count, Current) when Current =:= 1 ->
    Count;
reinitialize_permutation(N, Count, Current) ->
    NewCurrent = if
        Current rem 2 =:= 0 -> Current div 2;
        true -> N div 2 + (Current - 1) div 2
    end,
    reinitialize_permutation(N, Count + 1, NewCurrent).