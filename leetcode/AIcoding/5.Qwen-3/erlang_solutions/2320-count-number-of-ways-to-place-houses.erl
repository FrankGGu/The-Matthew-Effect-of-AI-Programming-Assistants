-module(solution).
-export([house_robber/1]).

house_robber([]) -> 0;
house_robber([H|T]) ->
    house_robber(T, H, 0).

house_robber([], Current, Previous) ->
    max(Current, Previous);
house_robber([H|T], Current, Previous) ->
    NewCurrent = Previous + H,
    NewPrevious = Current,
    house_robber(T, NewCurrent, NewPrevious).