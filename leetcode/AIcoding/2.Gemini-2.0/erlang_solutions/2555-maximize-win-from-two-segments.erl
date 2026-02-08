-module(maximize_win_from_two_segments).
-export([maximize_win_count/3]).

maximize_win_count(L, P, K) ->
    maximize_win_count(L, P, K, 0, 0).

maximize_win_count(L, P, K, Max, I) when I > length(P) - 1 ->
    Max;
maximize_win_count(L, P, K, Max, I) ->
    Win1 = count_in_range(P, I, K),
    Win2 = find_max_other_range(L, P, I, K),
    NewMax = max(Max, Win1 + Win2),
    maximize_win_count(L, P, K, NewMax, I + 1).

count_in_range(P, Start, K) ->
    End = find_end(P, Start, K),
    End - Start + 1.

find_end(P, Start, K) ->
    find_end(P, Start, K, Start).

find_end(P, Start, K, End) when End >= length(P) ->
    End - 1;
find_end(P, Start, K, End) ->
    if
        element(End + 1, P) - element(Start + 1, P) =< K ->
            find_end(P, Start, K, End + 1);
        true ->
            End - 1
    end.

find_max_other_range(L, P, I, K) ->
    End1 = find_end(P, I, K),
    find_max_other_range(L, P, K, 0, 0, End1 + 1).

find_max_other_range(L, P, K, Max, J, Start) when J > length(P) - 1 ->
    Max;
find_max_other_range(L, P, K, Max, J, Start) ->
    if
        J >= Start ->
            Win = count_in_range(P, J, K),
            NewMax = max(Max, Win),
            find_max_other_range(L, P, K, NewMax, J + 1, Start);
        true ->
            find_max_other_range(L, P, K, Max, J + 1, Start)
    end.