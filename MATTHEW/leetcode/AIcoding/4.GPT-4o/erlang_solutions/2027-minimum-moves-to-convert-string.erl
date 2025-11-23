-module(solution).
-export([minimum_moves/1]).

minimum_moves(S) ->
    Count = lists:filter(fun(X) -> X =:= $A end, S),
    Length = length(S) - Count,
    Length + div(Count, 3).