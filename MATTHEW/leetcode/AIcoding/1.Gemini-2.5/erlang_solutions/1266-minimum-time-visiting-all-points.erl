-module(solution).
-export([min_time_to_visit_all_points/1]).

min_time_to_visit_all_points([]) -> 0;
min_time_to_visit_all_points([_]) -> 0;
min_time_to_visit_all_points([CurrentPoint | RestPoints]) ->
    min_time_acc(RestPoints, CurrentPoint, 0).

min_time_acc([], _LastPoint, Acc) -> Acc;
min_time_acc([[NextX, NextY] | RestPoints], [CurrentX, CurrentY], Acc) ->
    Dx = abs(NextX - CurrentX),
    Dy = abs(NextY - CurrentY),
    SegmentTime = max(Dx, Dy),
    min_time_acc(RestPoints, [NextX, NextY], Acc + SegmentTime).