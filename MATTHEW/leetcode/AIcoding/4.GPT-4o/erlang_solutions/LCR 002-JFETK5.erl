-module(solution).
-export([add_binary/2]).

add_binary(A, B) ->
    BinA = list_to_binary(A),
    BinB = list_to_binary(B),
    BinSum = binary_to_list(BinA + BinB),
    list_to_binary(BinSum).