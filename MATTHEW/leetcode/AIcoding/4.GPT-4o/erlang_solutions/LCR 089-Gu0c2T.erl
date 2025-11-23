-module(solution).
-export([rob/1]).

rob(Houses) ->
    rob(Houses, 0, 0).

rob([], Prev, Curr) ->
    max(Prev, Curr);
rob([H | T], Prev, Curr) ->
    rob(T, Curr, max(Curr, Prev + H)).

max(A, B) when A > B -> A;
max(_, B) -> B.