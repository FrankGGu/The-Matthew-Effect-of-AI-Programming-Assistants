-module(special_array_ii).
-export([solve/1]).

solve(Nums) ->
    N = length(Nums),
    Max = lists:max(Nums),
    Count = lists:foldl(fun(X, Acc) -> Acc + 1 end, 0, Nums),
    case Count of
        C when C > Max -> 0;
        _ -> 1
    end.