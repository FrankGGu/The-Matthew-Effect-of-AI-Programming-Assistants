-module(solution).
-export([addBinary/2]).

addBinary(A, B) ->
    IntA = list_to_integer(A, 2),
    IntB = list_to_integer(B, 2),
    Sum = IntA + IntB,
    integer_to_list(Sum, 2).