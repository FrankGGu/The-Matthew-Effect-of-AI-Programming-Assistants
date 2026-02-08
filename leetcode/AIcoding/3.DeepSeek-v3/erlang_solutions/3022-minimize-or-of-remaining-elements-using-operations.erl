-module(solution).
-export([minimize_or/1]).

minimize_or(Nums) ->
    N = length(Nums),
    if
        N == 1 -> 0;
        true ->
            lists:foldl(fun(_, Acc) -> Acc bor 0 end, 0, lists:seq(1, N - 1))
    end.