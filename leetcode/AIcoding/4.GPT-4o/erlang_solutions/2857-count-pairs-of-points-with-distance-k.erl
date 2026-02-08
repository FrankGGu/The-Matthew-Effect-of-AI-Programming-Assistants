-module(solution).
-export([countPairs/2]).

countPairs(Points, K) ->
    Count = lists:foldl(fun({X1, Y1}, Acc1) ->
        Acc2 = lists:foldl(fun({X2, Y2}, Acc) ->
            if
                (X1 - X2)^2 + (Y1 - Y2)^2 =:= K*K -> Acc + 1;
                true -> Acc
            end
        end, Acc1, Points),
        Acc2
    end, 0, Points),
    Count div 2.