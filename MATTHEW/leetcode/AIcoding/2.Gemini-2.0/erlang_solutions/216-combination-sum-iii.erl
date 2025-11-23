-module(combination_sum_iii).
-export([combination_sum3/2]).

combination_sum3(K, N) ->
    combinations(K, N, 1, []).

combinations(0, 0, _, Acc) ->
    [lists:reverse(Acc)];
combinations(0, _, _, _) ->
    [];
combinations(_, 0, _, _) ->
    [];
combinations(K, N, Start, Acc) when N < 0 ->
    [];
combinations(K, N, Start, Acc) ->
    lists:flatten([combinations(K - 1, N - Start, Start + 1, [Start | Acc]) || Start =< 9, Start =< N, Start =< 10 - K, Start >= Start, Start =< N], []).