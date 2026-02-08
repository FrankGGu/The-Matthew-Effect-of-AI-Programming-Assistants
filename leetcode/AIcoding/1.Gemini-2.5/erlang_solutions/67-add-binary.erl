-module(add_binary).
-export([add_binary/2]).

add_binary(A, B) ->
    IntA = binary_to_integer(A, 2),
    IntB = binary_to_integer(B, 2),
    Sum = IntA + IntB,
    integer_to_binary(Sum, 2).