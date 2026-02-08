-module(solution).
-export([max_dist_to_closest/1]).

max_dist_to_closest(Seats) ->
    N = length(Seats),
    Max = 0,
    First = find_first(Seats, 0),
    Last = find_last(Seats, N-1),
    Max1 = case First of
        -1 -> 0;
        _ -> First
    end,
    Max2 = N - 1 - Last,
    Max3 = find_max_gap(Seats),
    lists:max([Max1, Max2, Max3]).

find_first([], _) -> -1;
find_first([0|T], I) -> find_first(T, I+1);
find_first([1|_], I) -> I.

find_last([], _) -> -1;
find_last([1|_], I) -> I;
find_last([0|T], I) -> find_last(T, I-1).

find_max_gap(Seats) ->
    Max = 0,
    Prev = -1,
    find_max_gap(Seats, 0, Prev, Max).

find_max_gap([], _, _, Max) -> Max;
find_max_gap([1|T], I, Prev, Max) ->
    if
        Prev == -1 -> find_max_gap(T, I+1, I, Max);
        true -> NewMax = (I - Prev - 1) div 2,
                find_max_gap(T, I+1, I, max(Max, NewMax))
    end;
find_max_gap([0|T], I, Prev, Max) ->
    find_max_gap(T, I+1, Prev, Max).