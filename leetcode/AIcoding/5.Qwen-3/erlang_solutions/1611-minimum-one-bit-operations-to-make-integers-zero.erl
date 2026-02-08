-module(minimum_one_bit_operations_to_make_integers_zero).
-export([minimumOneBitOperations/1]).

minimumOneBitOperations(N) ->
    minimumOneBitOperations(N, 0).

minimumOneBitOperations(0, Acc) ->
    Acc;
minimumOneBitOperations(N, Acc) ->
    minimumOneBitOperations(N bsr 1, (Acc bxor N)).