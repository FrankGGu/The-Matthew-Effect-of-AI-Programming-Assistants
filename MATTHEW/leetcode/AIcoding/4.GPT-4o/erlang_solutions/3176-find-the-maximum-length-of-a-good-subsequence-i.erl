-module(solution).
-export([maxLength/1]).

maxLength(S) ->
    lists:length(lists:filter(fun(X) -> X > 0 end, S)).