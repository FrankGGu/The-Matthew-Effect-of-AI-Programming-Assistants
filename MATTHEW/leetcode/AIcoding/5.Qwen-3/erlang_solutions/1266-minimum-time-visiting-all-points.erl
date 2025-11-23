-module(minimum_time_visiting_all_points).
-export([minTimeToVisitAllPoints/1]).

minTimeToVisitAllPoints(Points) ->
    minTimeToVisitAllPoints(Points, 0).

minTimeToVisitAllPoints([], Acc) ->
    Acc;
minTimeToVisitAllPoints([_], Acc) ->
    Acc;
minTimeToVisitAllPoints([[X1,Y1],[X2,Y2]|Rest], Acc) ->
    Dx = abs(X1 - X2),
    Dy = abs(Y1 - Y2),
    Step = max(Dx, Dy),
    minTimeToVisitAllPoints([[X2,Y2]|Rest], Acc + Step).