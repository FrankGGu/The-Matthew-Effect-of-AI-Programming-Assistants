-module(solution).
-export([smallestNumber/1]).

smallestNumber(N) when N > 0 ->
    (1 bsl N) - 1.