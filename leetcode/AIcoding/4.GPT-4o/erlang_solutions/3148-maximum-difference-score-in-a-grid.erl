-module(max_difference_score).
-export([max_difference_score/1]).

max_difference_score(Grid) ->
    MaxDiff = max_difference(Grid, 0, 0, 0),
    MaxDiff.

max_difference([], _, _, Max) -> Max;
max_difference([Row | Rest], Min, Max, CurrentMax) ->
    NewMin = lists:min([Min | Row]),
    NewMax = lists:max([Max | Row]),
    CurrentMax1 = max(CurrentMax, NewMax - NewMin),
    max_difference(Rest, NewMin, NewMax, CurrentMax1).