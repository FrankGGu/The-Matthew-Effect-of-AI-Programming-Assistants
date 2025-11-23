-module(solution).
-export([maxDivScore/2]).

maxDivScore(N, nums) ->
    lists:max(fun(X) -> {score(X, N), X} end, nums).

score(X, N) ->
    lists:foldl(fun(Y, Acc) -> if
        Y rem X =:= 0 -> Acc + 1;
        true -> Acc
    end end, 0, N).