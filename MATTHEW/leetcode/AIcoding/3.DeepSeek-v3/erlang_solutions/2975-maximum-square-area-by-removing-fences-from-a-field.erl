-module(solution).
-export([maximize_square_area/2]).

maximize_square_area(M, N, H, V) ->
    HSet = sets:from_list(H),
    VSet = sets:from_list(V),
    MaxH = find_max_gap(HSet, M),
    MaxV = find_max_gap(VSet, N),
    case MaxH * MaxV of
        0 -> 0;
        Area -> Area rem 1000000007
    end.

find_max_gap(Set, Max) ->
    lists:max([1 | [Gap || Gap <- consecutive_gaps(Set, Max)]]).

consecutive_gaps(Set, Max) ->
    Sorted = lists:sort(sets:to_list(Set)),
    consecutive_gaps(Sorted, 0, Max, []).

consecutive_gaps([], Prev, Max, Acc) ->
    [Max - Prev | Acc];
consecutive_gaps([H | T], Prev, Max, Acc) ->
    Gap = H - Prev,
    consecutive_gaps(T, H, Max, [Gap | Acc]).