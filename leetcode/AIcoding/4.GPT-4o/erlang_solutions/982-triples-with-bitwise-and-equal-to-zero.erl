-module(solution).
-export([countTriplets/1]).

countTriplets(N) ->
    lists:foldl(fun(X, Acc) ->
        lists:foldl(fun(Y, Acc2) ->
            lists:foldl(fun(Z, Acc3) ->
                if (X band Y band Z) =:= 0 -> Acc3 + 1; true -> Acc3 end
            end, Acc2, lists:seq(1, N))
        end, Acc, lists:seq(1, N))
    end, 0, lists:seq(1, N).