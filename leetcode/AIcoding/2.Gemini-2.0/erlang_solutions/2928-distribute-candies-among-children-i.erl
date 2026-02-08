-module(distribute_candies).
-export([distribute_candies/2]).

distribute_candies(N, Limit) ->
  lists:sum([1 || X <- lists:seq(0, Limit),
                  Y <- lists:seq(0, Limit - X),
                  Z <- lists:seq(0, Limit - X - Y),
                  X + Y + Z =:= N]).