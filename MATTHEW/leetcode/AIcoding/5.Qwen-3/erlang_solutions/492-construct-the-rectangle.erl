-module(solution).
-export([construct_rectangle/1]).

construct_rectangle(Area) ->
    construct_rectangle(Area, trunc(math:sqrt(Area))).

construct_rectangle(_, 0) ->
    [];
construct_rectangle(Area, W) ->
    case Area rem W of
        0 ->
            [Area div W, W];
        _ ->
            construct_rectangle(Area, W - 1)
    end.