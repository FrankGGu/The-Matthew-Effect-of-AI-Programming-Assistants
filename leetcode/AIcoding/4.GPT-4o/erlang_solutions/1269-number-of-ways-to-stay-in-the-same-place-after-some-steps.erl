-module(solution).
-export([num_ways/2]).

num_ways(N, K) ->
    mod(num_ways_helper(N, K), 1000000007).

num_ways_helper(0, _) -> 1;
num_ways_helper(_, 0) -> 0;
num_ways_helper(N, K) ->
    num_ways_helper(N - 1, K - 1) + 
    num_ways_helper(N + 1, K - 1) + 
    num_ways_helper(N, K - 1).