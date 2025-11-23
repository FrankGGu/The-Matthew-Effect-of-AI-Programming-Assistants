-module(solution).
-export([max_chunks_to_make_sorted/1]).

max_chunks_to_make_sorted(A) ->
    max_chunks(A, 0, 0).

max_chunks([], MaxChunks, _) -> 
    MaxChunks;
max_chunks([H | T], MaxChunks, RunningMax) ->
    RunningMax1 = max(RunningMax, H),
    if 
        RunningMax1 =:= length(A) - length(T) - 1 -> 
            max_chunks(T, MaxChunks + 1, RunningMax1);
        true -> 
            max_chunks(T, MaxChunks, RunningMax1)
    end.