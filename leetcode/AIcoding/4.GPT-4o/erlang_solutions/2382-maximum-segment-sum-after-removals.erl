-module(solution).
-export([maximumSegmentSum/2]).

maximumSegmentSum(N, A) ->
    Max = lists:max(A),
    remove_segments(N, A, Max, 0, 0).

remove_segments(_, [], _, Sum, Max) ->
    Max;
remove_segments(N, [H|T], Max, Sum, CurrentMax) ->
    NewSum = if H < 0 -> Sum; true -> Sum + H end,
    NewMax = max(CurrentMax, NewSum),
    if NewSum < 0 -> remove_segments(N, T, Max, 0, NewMax); true -> remove_segments(N, T, Max, NewSum, NewMax) end.