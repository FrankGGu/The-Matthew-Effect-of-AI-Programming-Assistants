-module(solution).
-export([min_deletions/2]).

min_deletions(Nums, Divisor) ->
    N = length(Nums),
    Count = lists:foldl(fun(X, Acc) -> 
        case X rem Divisor of
            0 -> Acc + 1;
            _ -> Acc
        end
    end, 0, Nums),
    if
        Count == 0 -> -1;
        true -> N - Count
    end.