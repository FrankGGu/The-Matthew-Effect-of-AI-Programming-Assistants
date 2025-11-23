-module(solution).
-export([num_ways/1]).

num_ways(Buildings) ->
    num_ways(Buildings, 0, 0, 0, 0).

num_ways([], _, _, _, Acc) ->
    Acc;
num_ways([0 | T], Ones, Zeros, Count, Acc) ->
    num_ways(T, Ones, Zeros + 1, Count, Acc);
num_ways([1 | T], Ones, Zeros, Count, Acc) ->
    num_ways(T, Ones + 1, Zeros, Count + Zeros, Acc).