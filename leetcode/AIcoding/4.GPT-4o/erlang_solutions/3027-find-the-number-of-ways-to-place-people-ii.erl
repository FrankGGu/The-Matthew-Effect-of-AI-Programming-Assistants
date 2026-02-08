-module(solution).
-export([count_ways/2]).

count_ways(N, K) ->
    if 
        N == 0 -> 
            1;
        K == 0 -> 
            0;
        true -> 
            count_ways(N - 1, K - 1) + count_ways(N, K - 1) * K
    end.