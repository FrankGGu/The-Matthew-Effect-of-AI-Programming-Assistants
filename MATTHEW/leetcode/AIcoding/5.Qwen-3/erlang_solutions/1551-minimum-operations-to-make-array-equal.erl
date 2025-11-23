-module(minimum_operations).
-export([minOperations/1]).

minOperations(N) ->
    minOperations(N, 0, 0).

minOperations(0, _, Acc) ->
    Acc;
minOperations(N, I, Acc) ->
    Val = 2 * I + 1,
    minOperations(N - 1, I + 1, Acc + abs(Val - N)).