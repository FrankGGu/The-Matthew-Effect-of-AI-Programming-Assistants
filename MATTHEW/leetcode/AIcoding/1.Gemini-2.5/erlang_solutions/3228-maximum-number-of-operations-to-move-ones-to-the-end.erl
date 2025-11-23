-module(solution).
-export([maxOperations/1]).

maxOperations(S) ->
    max_ops_acc(S, 0, 0).

max_ops_acc([], _OnesCount, TotalOps) ->
    TotalOps;
max_ops_acc([H|T], OnesCount, TotalOps) when H == $1 ->
    max_ops_acc(T, OnesCount + 1, TotalOps);
max_ops_acc([H|T], OnesCount, TotalOps) when H == $0 ->
    max_ops_acc(T, OnesCount, TotalOps + OnesCount).