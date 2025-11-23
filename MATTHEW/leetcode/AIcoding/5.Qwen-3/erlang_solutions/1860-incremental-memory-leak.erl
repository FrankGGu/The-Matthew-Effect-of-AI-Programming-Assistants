-module(solution).
-export([mem_leak/2]).

mem_leak(Start, A) ->
    mem_leak(Start, A, []).

mem_leak(0, _, Acc) ->
    lists:reverse(Acc);
mem_leak(N, [H|T], Acc) ->
    NewN = N - H,
    mem_leak(NewN, T, [H | Acc]);
mem_leak(N, [], Acc) ->
    mem_leak(N, lists:reverse(Acc), Acc).