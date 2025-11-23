-module(solution).
-export([get_size/1]).

get_size(Df) ->
    Rows = length(Df),
    Columns =
        case Df of
            [] -> 0;
            [H|_T] -> length(H)
        end,
    [Rows, Columns].