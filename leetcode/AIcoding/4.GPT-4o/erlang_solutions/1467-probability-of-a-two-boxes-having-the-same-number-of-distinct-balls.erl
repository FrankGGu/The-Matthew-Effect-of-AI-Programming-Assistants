-module(solution).
-export([getProbability/2]).

getProbability(Box1, Box2) ->
    Distinct1 = lists:usort(Box1),
    Distinct2 = lists:usort(Box2),
    Count1 = length(Distinct1),
    Count2 = length(Distinct2),
    if Count1 =:= Count2 -> 1.0; true -> 0.0 end.