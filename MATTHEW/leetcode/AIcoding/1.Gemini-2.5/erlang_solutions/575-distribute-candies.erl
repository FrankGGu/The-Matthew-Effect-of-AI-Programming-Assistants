-module(solution).
-export([distributeCandies/1]).

distributeCandies(CandyType) ->
    UniqueTypes = sets:size(sets:from_list(CandyType)),
    MaxCandiesToEat = length(CandyType) div 2,
    min(UniqueTypes, MaxCandiesToEat).