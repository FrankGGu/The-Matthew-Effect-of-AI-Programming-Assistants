-module(solution).
-export([hammingDistance/2]).

hammingDistance(X, Y) ->
    XorResult = X bxor Y,
    count_set_bits(XorResult, 0).

count_set_bits(0, Count) ->
    Count;
count_set_bits(N, Count) ->
    case N band 1 of
        1 ->
            count_set_bits(N bsr 1, Count + 1);
        0 ->
            count_set_bits(N bsr 1, Count)
    end.