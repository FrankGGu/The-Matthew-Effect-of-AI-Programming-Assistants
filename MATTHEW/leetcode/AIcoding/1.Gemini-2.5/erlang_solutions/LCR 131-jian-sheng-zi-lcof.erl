-module(solution).
-export([solve/2]).

solve(BambooHeights, K) ->
    lists:foldl(fun(H, Acc) ->
                    Acc + ((H - 1) div K)
                end, 0, BambooHeights).