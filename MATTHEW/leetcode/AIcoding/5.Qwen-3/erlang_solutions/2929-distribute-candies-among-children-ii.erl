-module(distribute_candies).
-export([distribute_candies/2]).

distribute_candies(NumChildren, NumCandies) ->
    distribute_candies(NumChildren, NumCandies, 1, []).

distribute_candies(_, 0, _, Acc) ->
    lists:reverse(Acc);
distribute_candies(NumChildren, NumCandies, CurrentChild, Acc) ->
    Candies = min(NumCandies, CurrentChild),
    distribute_candies(NumChildren, NumCandies - Candies, CurrentChild + 1, [Candies | Acc]).