-module(distribute_candies).
-export([distribute_candies/1]).

distribute_candies(Candies) ->
    S = lists:usort(Candies),
    min(length(S), length(Candies) div 2).