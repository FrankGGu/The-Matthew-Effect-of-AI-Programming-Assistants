-module(solution).
-export([max_chunks_to_sorted/1]).

max_chunks_to_sorted(Arr) ->
    max_chunks_to_sorted_helper(Arr, 0, 0, 0).

max_chunks_to_sorted_helper([], _Index, _CurrentMax, Chunks) ->
    Chunks;
max_chunks_to_sorted_helper([H|T], Index, CurrentMax, Chunks) ->
    NewCurrentMax = max(CurrentMax, H),
    NewChunks = if NewCurrentMax == Index -> Chunks + 1;
                   true -> Chunks
                end,
    max_chunks_to_sorted_helper(T, Index + 1, NewCurrentMax, NewChunks).