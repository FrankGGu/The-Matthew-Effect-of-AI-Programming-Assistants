-module(solution).
-export([isThreeDivisors/1]).

isThreeDivisors(N) ->
    if
        N < 4 -> false;
        true -> 
            S = trunc(math:sqrt(N)),
            S * S =:= N andalso S * S < N + 1
    end.