-module(my_sqrt).
-export([my_sqrt/1]).

my_sqrt(X) ->
    my_sqrt(X, 0, X).

my_sqrt(X, Low, High) ->
    Mid = (Low + High) div 2,
    case Mid * Mid of
        Val when Val == X -> Mid;
        Val when Val > X -> my_sqrt(X, Low, Mid - 1);
        _ -> my_sqrt(X, Mid + 1, High)
    end.