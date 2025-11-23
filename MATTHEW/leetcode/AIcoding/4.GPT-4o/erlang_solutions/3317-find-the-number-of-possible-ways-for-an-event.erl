-module(solution).
-export([numWays/2]).

numWays(N, K) ->
    If N == 0 -> 
        0;
    If N == 1 -> 
        K;
    If N == 2 -> 
        K * K;
    Else -> 
        K * (K - 1) * numWays(N - 2, K)
    end.