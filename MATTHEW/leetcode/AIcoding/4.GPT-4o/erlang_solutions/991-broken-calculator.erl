-module(solution).
-export([broken_calculator/2]).

broken_calculator(X, Y) ->
    case X >= Y of
        true -> X - Y;
        false -> calculate(X, Y)
    end.

calculate(X, Y) ->
    case Y rem 2 of
        0 -> calculate(X, Y div 2) + 1;
        _ -> calculate(X, Y + 1) + 1
    end.