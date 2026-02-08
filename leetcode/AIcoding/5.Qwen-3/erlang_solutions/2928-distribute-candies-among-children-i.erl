-module(distribute_candies).
-export([distribute_candies/2]).

distribute_candies(Children, Candies) ->
    distribute_candies(Children, Candies, 1, []).

distribute_candies(0, _, _, Result) ->
    lists:reverse(Result);
distribute_candies(Children, Candies, Step, Result) ->
    Take = min(Step, Candies),
    distribute_candies(Children - 1, Candies - Take, Step + 1, [Take | Result]).