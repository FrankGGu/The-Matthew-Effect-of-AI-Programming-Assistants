-module(solution).
-export([num_of_ways/1]).

num_of_ways(N) ->
    if
        N == 0 -> 1;
        N == 1 -> 1;
        true -> (num_of_ways(N - 1) + num_of_ways(N - 2)) rem 1000000007
    end.