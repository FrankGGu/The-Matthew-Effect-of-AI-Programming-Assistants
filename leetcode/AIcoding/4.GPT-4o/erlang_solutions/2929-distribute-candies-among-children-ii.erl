-module(solution).
-export([distribute_candies/2]).

distribute_candies(Candies, Num_people) ->
    distribute_candies(Candies, Num_people, 0).

distribute_candies(Candies, Num_people, Round) when Candies > 0 ->
    give = min(Candies, Round + 1),
    distribute_candies(Candies - give, Num_people, Round + 1);
distribute_candies(_, _, _) ->
    0.