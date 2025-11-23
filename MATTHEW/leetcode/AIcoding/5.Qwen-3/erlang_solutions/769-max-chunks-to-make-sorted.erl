-module(max_chunks_to_make_sorted).
-export([max_chunks_to_make_sorted/1]).

max_chunks_to_make_sorted(Arr) ->
    max_chunks_to_make_sorted(Arr, 0, 0).

max_chunks_to_make_sorted([], _, Count) ->
    Count;
max_chunks_to_make_sorted([H | T], MaxSoFar, Count) ->
    NewMax = max(MaxSoFar, H),
    if
        NewMax == length(T) + 1 ->
            max_chunks_to_make_sorted(T, 0, Count + 1);
        true ->
            max_chunks_to_make_sorted(T, NewMax, Count)
    end.