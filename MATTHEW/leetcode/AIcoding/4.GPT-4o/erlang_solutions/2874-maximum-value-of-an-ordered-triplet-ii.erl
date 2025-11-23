-module(solution).
-export([maximum_value/1]).

maximum_value(List) ->
    Max = lists:max(List),
    lists:foldl(fun(X, Acc) ->
        lists:foldl(fun(Y, Acc2) ->
            lists:foldl(fun(Z, Acc3) ->
                max(Acc3, (X + Y) * Z)
            end, Acc2, List)
        end, Acc, List)
    end, Max, List).