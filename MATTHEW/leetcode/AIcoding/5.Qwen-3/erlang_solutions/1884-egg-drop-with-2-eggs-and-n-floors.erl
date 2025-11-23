-module(egg_drop).
-export([drop/1]).

drop(N) ->
    drop(2, N, 1, 0).

drop(1, _, _, K) ->
    K;
drop(_, N, K, S) when S >= N ->
    K;
drop(Eggs, N, K, S) ->
    drop(Eggs, N, K + 1, S + K).