module Solution.

-export([maxScoreSightseeingPair/1]).

maxScoreSightseeingPair(A) ->
    maxScoreSightseeingPair(A, 0, 0, length(A)).

maxScoreSightseeingPair([], _, Max, _) ->
    Max;
maxScoreSightseeingPair([H|T], PrevMax, Max, N) ->
    NewMax = lists:max([PrevMax + H - length(T) - 1, Max]),
    maxScoreSightseeingPair(T, PrevMax + H, NewMax, N - 1).