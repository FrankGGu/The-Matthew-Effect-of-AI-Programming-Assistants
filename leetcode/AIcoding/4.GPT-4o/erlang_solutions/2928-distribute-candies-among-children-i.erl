-module(solution).
-export([distribute_candies/2]).

distribute_candies(Candies, Num_people) ->
    integer:mod(Candies, Num_people) + (Candies div Num_people) * (Num_people + 1) div 2.