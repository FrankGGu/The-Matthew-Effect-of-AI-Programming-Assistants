-module(solution).
-export([isPowerOfFour/1]).

isPowerOfFour(N) when N > 0 ->
    (N band (N - 1)) == 0 andalso (N band 16#AAAAAAAA) == 0;
isPowerOfFour(_) ->
    false.