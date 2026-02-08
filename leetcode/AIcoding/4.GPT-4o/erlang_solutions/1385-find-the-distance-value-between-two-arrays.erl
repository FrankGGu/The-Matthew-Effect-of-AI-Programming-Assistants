-module(solution).
-export([findDistanceValue/2]).

findDistanceValue(A, B) ->
    AList = lists:sort(A),
    lists:foldl(fun(X, Acc) ->
        Count = lists:foldl(fun(Y, Acc1) ->
            if
                abs(X - Y) < 1 -> Acc1 + 1;
                true -> Acc1
            end
        end, 0, B),
        if
            Count =:= 0 -> Acc + 1;
            true -> Acc
        end
    end, 0, AList).