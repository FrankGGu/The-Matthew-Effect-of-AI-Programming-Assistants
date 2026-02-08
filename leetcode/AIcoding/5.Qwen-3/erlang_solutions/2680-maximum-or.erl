-module(max_or).
-export([maxOr/1]).

maxOr(Nums) ->
    Max = lists:max(Nums),
    N = length(Nums),
    Result = 0,
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if I /= J -> Acc2 bor (lists:nth(I+1, Nums) bor lists:nth(J+1, Nums));
               true -> Acc2
            end
        end, Acc, lists:seq(0, N-1))
    end, Result, lists:seq(0, N-1)).