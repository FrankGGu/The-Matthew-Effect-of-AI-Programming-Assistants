-module(beautiful_arrangement_ii).
-export([construct_array/2]).

construct_array(N, K) ->
    lists:seq(1, N).

construct_array(N, K) when K >= 1, K < N ->
    Result = lists:seq(1, N),
    Front = lists:seq(1, N - K - 1),
    Middle = build_middle(N - K, N, K),
    Front ++ Middle.

build_middle(L, R, K) when K > 0 ->
    [L | build_middle(R, L+1, K - 1)];
build_middle(L, R, K) when K =:= 0 ->
    lists:seq(L, R).