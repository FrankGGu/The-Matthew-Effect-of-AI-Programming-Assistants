-module(solution).
-export([minimum_operations/2]).

minimum_operations(X, Y) when X >= Y -> X - Y;
minimum_operations(X, Y) ->
    case Y rem 2 of
        0 -> 1 + minimum_operations(X, Y div 2);
        1 -> 1 + minimum_operations(X, Y + 1)
    end.