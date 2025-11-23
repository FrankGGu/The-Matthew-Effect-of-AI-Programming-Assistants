-module(solution).
-export([isPowerOfThree/1]).

isPowerOfThree(N) when N =< 0 -> false;
isPowerOfThree(N) ->
    MaxPowerOfThree = 1162261467,
    MaxPowerOfThree rem N == 0.