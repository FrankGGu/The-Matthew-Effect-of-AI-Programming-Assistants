-module(sqrt_x).
-export([my_sqrt/1]).

my_sqrt(X) ->
    my_sqrt(X, 0, X).

my_sqrt(X, Low, High) when Low > High ->
    High;
my_sqrt(X, Low, High) ->
    Mid = Low + (High - Low) div 2,
    Square = Mid * Mid,
    case Square of
        _ when Square =:= X ->
            Mid;
        _ when Square < X ->
            my_sqrt(X, Mid + 1, High);
        _ ->
            my_sqrt(X, Low, Mid - 1)
    end.