-module(solution).
-export([maxPoints/1]).

maxPoints(Marbles) ->
    lists:max(lists:map(fun(X) -> X * (X + 1) div 2 end, Marbles)).