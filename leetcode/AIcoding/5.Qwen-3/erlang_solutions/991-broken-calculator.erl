-module(broken_calculator).
-export([broken_calc/2]).

broken_calc(X, Y) ->
    broken_calc(X, Y, 0).

broken_calc(X, Y, Steps) when X >= Y ->
    Steps + (X - Y);
broken_calc(X, Y, Steps) when Y rem 2 == 0 ->
    broken_calc(X, Y div 2, Steps + 1);
broken_calc(X, Y, Steps) ->
    broken_calc(X, Y + 1, Steps + 1).