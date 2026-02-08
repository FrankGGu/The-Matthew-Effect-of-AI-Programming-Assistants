-module(minimum_one_bit_operations).
-export([solve/1]).

solve(N) ->
    gray_code_to_binary(N).

gray_code_to_binary(N) ->
    binary_to_integer(gray_code_to_binary_bits(N, [])).

gray_code_to_binary_bits(0, Acc) ->
    lists:reverse(Acc);
gray_code_to_binary_bits(N, Acc) ->
    gray_code_to_binary_bits(N bsr 1, [xor(N, N bsr 1) | Acc]).

binary_to_integer(Bits) ->
    lists:foldl(fun(Bit, Acc) -> (Acc * 2) + Bit end, 0, Bits).

xor(A, B) ->
    case (A band 1) =/= (B band 1) of
        true -> 1;
        false -> 0
    end.