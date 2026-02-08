-module(solution).
-export([xor_operation/2]).

xor_operation(N, Start) ->
    xor_operation_helper(N, Start, 0).

xor_operation_helper(0, _Start, Acc) ->
    Acc;
xor_operation_helper(Count, Start, Acc) when Count > 0 ->
    Element = Start + 2 * (Count - 1),
    NewAcc = Acc bxor Element,
    xor_operation_helper(Count - 1, Start, NewAcc).