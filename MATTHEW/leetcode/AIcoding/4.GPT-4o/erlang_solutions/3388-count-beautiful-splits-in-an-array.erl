-module(solution).
-export([count_beautiful_splits/1]).

count_beautiful_splits(Array) ->
    N = length(Array),
    count_splits(Array, N, 0, 0, 0).

count_splits([], _, _, _, Count) -> Count;
count_splits([H | T], N, L, R, Count) ->
    NewL = L + H,
    NewR = R + (N - length(T) - 1) * H,
    if
        NewL == NewR -> 
            count_splits(T, N, NewL, R, Count + 1);
        true -> 
            count_splits(T, N, NewL, R, Count)
    end.