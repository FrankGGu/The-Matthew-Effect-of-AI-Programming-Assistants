-module(solution).
-export([num_of_ways/2]).

num_of_ways(N, K) ->
    if
        N == 1 -> K;
        N == 2 -> K * K;
        true -> K * (K - 1) * num_of_ways(N - 2, K) + K * num_of_ways(N - 1, K)
    end.