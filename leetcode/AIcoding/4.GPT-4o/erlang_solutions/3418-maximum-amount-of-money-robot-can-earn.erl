-module(solution).
-export([rob/1]).

rob(Houses) ->
    rob(Houses, length(Houses), 0, 0).

rob([], _, Prev1, Prev2) ->
    max(Prev1, Prev2);
rob([H | T], N, Prev1, Prev2) ->
    rob(T, N - 1, Prev2, max(Prev1 + H, Prev2)).