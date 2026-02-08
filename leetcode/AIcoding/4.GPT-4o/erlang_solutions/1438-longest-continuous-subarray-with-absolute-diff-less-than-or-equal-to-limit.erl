-module(solution).
-export([longest_subarray/2]).

longest_subarray(A, L) ->
    longest_subarray(A, L, 0, 0, 0, 0).

longest_subarray([], _, MaxLen, _, _, _) ->
    MaxLen;
longest_subarray([H | T], L, MaxLen, Start, End, Min) ->
    NewMin = min(H, Min),
    NewMax = max(H, End),
    if 
        NewMax - NewMin =< L ->
            longest_subarray(T, L, max(MaxLen, length([H | T]) - 1), NewMin, NewMax, NewMin);
        true ->
            longest_subarray(T, L, MaxLen, Start + 1, End, Min)
    end.