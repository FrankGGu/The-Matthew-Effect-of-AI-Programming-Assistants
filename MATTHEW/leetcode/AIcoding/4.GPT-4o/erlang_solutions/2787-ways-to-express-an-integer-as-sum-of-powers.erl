-module(solution).
-export([powerSum/2]).

powerSum(N, K) ->
    powerSum(N, K, 1).

powerSum(N, K, Base) when N < 0 -> 
    0;
powerSum(0, K, _) -> 
    1;
powerSum(N, K, Base) -> 
    powerSum(N - Base^K, K, Base + 1) + powerSum(N, K, Base + 1).