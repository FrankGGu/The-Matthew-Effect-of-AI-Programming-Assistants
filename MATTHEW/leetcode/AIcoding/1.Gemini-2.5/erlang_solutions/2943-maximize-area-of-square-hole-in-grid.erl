-module(solution).
-export([maximizeSquareHoleArea/3]).

maximizeSquareHoleArea(N, M, HBars, VBars) ->
    MaxHSide = calculate_max_side(M + 2, HBars),
    MaxVSide = calculate_max_side(N + 2, VBars),
    Side = min(MaxHSide, MaxVSide),
    Side * Side.

calculate_max_side(TotalBarCount, RemovedBarsList) ->
    RemovedSet = gb_sets:from_list(RemovedBarsList),
    MaxConsecutivePresent = calculate_max_side_loop(0, TotalBarCount, RemovedSet, 0, 0),
    MaxConsecutivePresent - 1.

calculate_max_side_loop(Index, TotalBarCount, RemovedSet, CurrentMax, CurrentCount) ->
    if
        Index == TotalBarCount ->
            max(CurrentMax, CurrentCount);
        gb_sets:is_member(Index, RemovedSet) ->
            NewMax = max(CurrentMax, CurrentCount),
            calculate_max_side_loop(Index + 1, TotalBarCount, RemovedSet, NewMax, 0);
        true -> %% Bar is present
            calculate_max_side_loop(Index + 1, TotalBarCount, RemovedSet, CurrentMax, CurrentCount + 1)
    end.