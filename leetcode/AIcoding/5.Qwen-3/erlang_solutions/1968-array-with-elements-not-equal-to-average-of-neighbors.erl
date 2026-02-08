-module(solution).
-export([solve/1]).

solve(Nums) ->
    N = length(Nums),
    Sorted = lists:sort(Nums),
    Result = lists:foldl(fun(I, Acc) -> 
        case I rem 2 of
            0 -> [lists:nth(I+1, Sorted) | Acc];
            _ -> [lists:nth(I+1, Sorted) | Acc]
        end
    end, [], lists:seq(0, N-1)),
    lists:reverse(Result).