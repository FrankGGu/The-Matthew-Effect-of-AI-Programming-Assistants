-module(solution).
-export([smallestNumber/1]).

smallestNumber(N) ->
    (1 bsl N) - 1.