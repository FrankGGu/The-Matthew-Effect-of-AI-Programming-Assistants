-module(minimum_operations).
-export([make_the_integer_zero/2]).

make_the_integer_zero(Num1, Num2) ->
    bits(Num1, Num2, 0).

bits(Num1, Num2, Count) ->
    if Num1 == 0 ->
        Count;
    true ->
        Bits = erlang:integer_to_list(Num1, 2),
        Len = length(Bits),
        Diff = Num1 - Len * Num2,
        if Diff >= Count andalso Len >= Count ->
            bits(Num1 - math:pow(2, least_significant_bit(Num1)), Num2, Count + 1);
        true ->
            -1
        end
    end.

least_significant_bit(N) ->
    least_significant_bit_helper(N, 0).

least_significant_bit_helper(0, Count) ->
    -1;
least_significant_bit_helper(N, Count) ->
    if N rem 2 == 1 ->
        Count;
    true ->
        least_significant_bit_helper(N div 2, Count + 1)
    end.