-module(solution).
-export([distribute_candies/1]).

distribute_candies(Candies) ->
    min(length(Candies) div 2, length(sets:from_list(Candies))).