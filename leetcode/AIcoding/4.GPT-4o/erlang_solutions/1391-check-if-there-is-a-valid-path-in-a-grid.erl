-module(solution).
-export([has_valid_path/2]).

has_valid_path(Grid, Start) ->
    {Rows, Cols} = lists:foldl(fun(Row, {R, C}) -> {R + 1, max(C, length(Row))} end, {0, 0}, Grid),
    {Rows, Cols}.

valid_path(Grid, Start) ->
    {R, C} = Start,
    case R of
        0 -> C =< length(Grid);
        _ -> R =< length(Grid)
    end.

has_valid_path(Grid, Start) ->
    valid_path(Grid, Start).