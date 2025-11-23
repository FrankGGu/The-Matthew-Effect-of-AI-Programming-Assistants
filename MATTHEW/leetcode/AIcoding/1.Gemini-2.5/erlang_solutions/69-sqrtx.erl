-module(solution).
-export([mySqrt/1]).

mySqrt(X) ->
    trunc(math:sqrt(X)).