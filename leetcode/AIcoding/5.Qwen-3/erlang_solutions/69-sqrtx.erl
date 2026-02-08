-module(my_sqrt).
-export([sqrt/1]).

sqrt(X) ->
    sqrt(X, 0, X).

sqrt(X, Low, High) when Low >= High ->
    Low;
sqrt(X, Low, High) ->
    Mid = (Low + High) div 2,
    case Mid * Mid of
        M when M > X ->
            sqrt(X, Low, Mid - 1);
        _ ->
            sqrt(X, Mid + 1, High)
    end.