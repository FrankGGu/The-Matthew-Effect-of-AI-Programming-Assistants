-module(solution).
-export([min_cost/2]).

min_cost(Price, S) ->
    min_cost(Price, S, 0, 0).

min_cost([], _, _, Cost) ->
    Cost;
min_cost([P | T], S, Index, Cost) ->
    case S of
        [C | Rest] when C == Index + $a ->
            min_cost(T, Rest, Index + 1, Cost + P);
        _ ->
            min_cost(T, S, Index + 1, Cost)
    end.