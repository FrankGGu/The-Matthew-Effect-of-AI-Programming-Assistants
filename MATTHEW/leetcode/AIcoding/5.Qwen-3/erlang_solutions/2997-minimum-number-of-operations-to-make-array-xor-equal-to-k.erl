-module(solution).
-export([min_operations/2]).

min_operations(A, K) ->
    min_operations(A, K, 0).

min_operations([], _, Acc) ->
    Acc;
min_operations([H | T], K, Acc) ->
    Bit = H bxor (Acc bnot 16#ff),
    min_operations(T, K, Acc + Bit).