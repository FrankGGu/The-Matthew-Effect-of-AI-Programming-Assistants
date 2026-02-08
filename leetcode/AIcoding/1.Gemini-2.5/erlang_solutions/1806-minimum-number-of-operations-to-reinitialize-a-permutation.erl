-module(solution).
-export([reinitialize_permutation/1]).

reinitialize_permutation(N) ->
    reinitialize_permutation_loop(N, 1, 0).

reinitialize_permutation_loop(N, CurrentIndex, Count) ->
    NewCount = Count + 1,
    NextIndex = 
        if
            CurrentIndex < N div 2 ->
                2 * CurrentIndex;
            true -> % CurrentIndex >= N div 2
                2 * (CurrentIndex - N div 2) + 1
        end,
    if
        NextIndex == 1 ->
            NewCount;
        true ->
            reinitialize_permutation_loop(N, NextIndex, NewCount)
    end.