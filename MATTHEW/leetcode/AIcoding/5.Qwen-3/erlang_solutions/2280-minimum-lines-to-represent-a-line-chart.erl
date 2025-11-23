-module(min_lines).
-export([minimum_lines/1]).

minimum_lines(Points) ->
    minimum_lines(Points, 0, []).

minimum_lines([], _Count, Acc) ->
    lists:reverse(Acc);
minimum_lines([_], _Count, Acc) ->
    lists:reverse(Acc);
minimum_lines([P1, P2 | Rest], Count, Acc) ->
    {X1, Y1} = P1,
    {X2, Y2} = P2,
    Slope = {Y2 - Y1, X2 - X1},
    minimum_lines([P2 | Rest], Count + 1, [Slope | Acc]).

minimum_lines([P1, P2 | Rest], Count, Acc, PrevSlope) ->
    {X1, Y1} = P1,
    {X2, Y2} = P2,
    Slope = {Y2 - Y1, X2 - X1},
    if
        Slope /= PrevSlope ->
            minimum_lines([P2 | Rest], Count + 1, [Slope | Acc], Slope);
        true ->
            minimum_lines([P2 | Rest], Count, Acc, Slope)
    end.

minimum_lines([_], _Count, Acc, _PrevSlope) ->
    lists:reverse(Acc).