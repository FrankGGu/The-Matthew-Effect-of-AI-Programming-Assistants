-module(solution).
-export([countKDifference/2]).

countKDifference(List, K) ->
    Pairs = lists:foldl(fun(X, Acc) ->
        Acc + lists:foldl(fun(Y, Acc1) ->
            if
                abs(X - Y) =:= K -> Acc1 + 1;
                true -> Acc1
            end
        end, 0, lists:delete(X, List))
    end, 0, List),
    Pairs div 2.