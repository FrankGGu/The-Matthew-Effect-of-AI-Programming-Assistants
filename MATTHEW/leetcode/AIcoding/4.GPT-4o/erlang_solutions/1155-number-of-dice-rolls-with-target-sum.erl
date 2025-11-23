-module(solution).
-export([numRollsToTarget/3]).

numRollsToTarget(N, K, T) ->
    M = 1000000007,
    DP = lists:duplicate(T + 1, 0),
    lists:foldl(fun(_, DP) ->
        lists:foldl(fun(roll, Acc) ->
            lists:map(fun(S) -> if S >= roll -> (Acc(S - roll) + Acc(S)) rem M; true -> Acc(S) end end, lists:seq(0, T))
        end, DP, lists:seq(1, K))
    end, lists:duplicate(T + 1, 0), lists:seq(1, N)),
    lists:nth(T + 1, DP).