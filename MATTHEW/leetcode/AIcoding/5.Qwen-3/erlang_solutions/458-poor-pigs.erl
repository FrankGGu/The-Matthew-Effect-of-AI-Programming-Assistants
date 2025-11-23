-module(poor_pigs).
-export([num_of_pigs/2]).

num_of_pigs(eggs, time) ->
    num_of_pigs(eggs, time, 0).

num_of_pigs(eggs, Time, T) when T >= Time ->
    T;
num_of_pigs(eggs, Time, T) ->
    num_of_pigs(eggs, Time, T + 1).