-module(minimum_operations_to_make_array_equal_ii).
-export([minOperations/2]).

minOperations(A, B) ->
    minOperations(A, B, 0).

minOperations([], [], Acc) ->
    Acc;
minOperations([AHead | ATail], [BHead | BTail], Acc) ->
    Diff = AHead - BHead,
    if
        Diff == 0 ->
            minOperations(ATail, BTail, Acc);
        true ->
            minOperations(ATail, BTail, Acc + 1)
    end.