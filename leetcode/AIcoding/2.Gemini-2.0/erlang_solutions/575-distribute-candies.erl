-module(distribute_candies).
-export([distribute_candies/1]).

distribute_candies(CandyType) ->
    Len = length(CandyType),
    Unique = length(lists:usort(CandyType)),
    min(Len div 2, Unique).