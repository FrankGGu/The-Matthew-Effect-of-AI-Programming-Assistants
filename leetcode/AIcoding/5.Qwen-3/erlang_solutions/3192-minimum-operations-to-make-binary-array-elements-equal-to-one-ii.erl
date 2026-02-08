-module(min_operations).
-export([minOperations/1]).

minOperations(B) ->
    minOperations(B, 0, 0).

minOperations([], _, Acc) ->
    Acc;
minOperations([H | T], Flip, Acc) ->
    Current = H bxor Flip,
    if
        Current == 1 ->
            minOperations(T, Flip, Acc);
        true ->
            NewFlip = 1 - Flip,
            minOperations(T, NewFlip, Acc + 1)
    end.