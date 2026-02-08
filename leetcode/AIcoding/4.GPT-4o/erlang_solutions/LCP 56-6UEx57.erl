-module(solution).
-export([send_token/2]).

send_token(N, K) ->
    lists:foldl(fun(_, Acc) ->
        (Acc + K) rem N
    end, 0, lists:seq(1, N) ++ [0]).