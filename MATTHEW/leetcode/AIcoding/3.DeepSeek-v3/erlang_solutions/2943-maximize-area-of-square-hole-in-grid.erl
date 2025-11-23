-module(solution).
-export([maximize_square_hole_area/2]).

maximize_square_hole_area(N, M, H_Bars, V_Bars) ->
    HSeq = find_consecutive_sequence(H_Bars),
    VSeq = find_consecutive_sequence(V_Bars),
    Min = min(HSeq, VSeq),
    (Min + 1) * (Min + 1).

find_consecutive_sequence(Bars) ->
    Sorted = lists:sort(Bars),
    MaxSeq = find_max_consecutive(Sorted, 1, 1),
    MaxSeq.

find_max_consecutive([], _, Max) -> Max;
find_max_consecutive([_], Curr, Max) -> max(Curr, Max);
find_max_consecutive([X, Y | Rest], Curr, Max) ->
    if
        Y == X + 1 -> find_max_consecutive([Y | Rest], Curr + 1, Max);
        true -> find_max_consecutive([Y | Rest], 1, max(Curr, Max))
    end.