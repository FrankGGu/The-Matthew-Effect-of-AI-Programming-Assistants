-module(solve).
-export([rob/1]).

rob([]) -> 0;
rob([H|T]) ->
    rob(H, T, 0, 0).

rob(_, [], Prev, Current) -> max(Prev, Current);
rob(First, [H|T], Prev, Current) ->
    Next = Current + H,
    NewPrev = Current,
    NewCurrent = max(Prev, Current),
    rob(First, T, NewPrev, NewCurrent).