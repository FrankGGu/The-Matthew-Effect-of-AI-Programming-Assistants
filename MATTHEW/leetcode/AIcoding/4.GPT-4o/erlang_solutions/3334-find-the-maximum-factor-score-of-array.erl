-module(solution).
-export([maxFactorScore/1]).

maxFactorScore(Array) ->
    Max = lists:max(Array),
    FactorCounts = lists:foldl(fun(X, Acc) ->
        Count = lists:foldl(fun(Y, C) when Y rem X =:= 0 -> C + 1; (_, C) -> C end, 0, Array),
        [{X, Count} | Acc]
    end, [], Array),
    lists:max(FactorCounts).