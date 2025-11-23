-module(house_robber).
-export([rob/1]).

rob([]) -> 0;
rob([H|T]) ->
    rob(H, T, 0, 0).

rob(_, [], Prev, Current) -> max(Prev, Current);
rob(H, [H2|T], Prev, Current) ->
    NewCurrent = max(Current, Prev + H),
    rob(H2, T, Current, NewCurrent).