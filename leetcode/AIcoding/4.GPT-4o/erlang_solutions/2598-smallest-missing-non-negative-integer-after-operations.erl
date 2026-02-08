-module(solution).
-export([smallest_missing_integer/1]).

smallest_missing_integer(Nums) ->
    Min = lists:min(Nums),
    Max = lists:max(Nums),
    Range = lists:seq(Min, Max),
    Missing = lists:filter(fun(X) -> not lists:member(X, Nums) end, Range),
    case Missing of
        [] -> Max + 1;
        _ -> lists:min(Missing)
    end.