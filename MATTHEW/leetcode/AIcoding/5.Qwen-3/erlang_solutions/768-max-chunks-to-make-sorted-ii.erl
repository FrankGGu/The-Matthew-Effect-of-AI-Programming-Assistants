-module(max_chunks_to_make_sorted_ii).
-export([maxChunksToMakeSorted/1]).

maxChunksToMakeSorted(A) ->
    maxChunksToMakeSorted(A, 0, 0, 0).

maxChunksToMakeSorted([], _, _, Count) ->
    Count;
maxChunksToMakeSorted([H | T], Index, MaxSoFar, Count) ->
    if
        H > MaxSoFar ->
            maxChunksToMakeSorted(T, Index + 1, H, Count + 1);
        true ->
            maxChunksToMakeSorted(T, Index + 1, MaxSoFar, Count)
    end.