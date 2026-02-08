-module(minimum_operations).
-export([minOperations/1]).

minOperations(A) ->
    minOperations(A, 1, 0).

minOperations([], _, Acc) ->
    Acc;
minOperations([H | T], Prev, Acc) ->
    if
        H > Prev -> minOperations(T, H, Acc);
        true -> minOperations(T, Prev + 1, Acc + (Prev + 1 - H))
    end.