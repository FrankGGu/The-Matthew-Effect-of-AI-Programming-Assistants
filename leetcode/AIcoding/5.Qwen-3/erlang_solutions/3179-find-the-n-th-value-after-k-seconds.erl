-module(solution).
-export([value_after_k_seconds/2]).

value_after_k_seconds(N, K) ->
    lists:nth(N, value_after_k_seconds(K, 1, [0])).

value_after_k_seconds(0, _, Acc) ->
    Acc;
value_after_k_seconds(K, Step, Acc) ->
    Next = lists:map(fun(X) -> X + 1 end, Acc),
    value_after_k_seconds(K - 1, Step + 1, Next).