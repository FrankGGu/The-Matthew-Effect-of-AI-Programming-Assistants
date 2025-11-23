-module(solution).
-export([maximal_score/2]).

maximal_score(N, K) ->
    Lists = lists:seq(1, N),
    Max = lists:max(Lists),
    lists:foldl(fun(X, Acc) -> Acc + (Max div X) end, 0, Lists) + K * Max.