-module(complement_of_base_10_integer).
-export([binary_complement/1]).

binary_complement(N) ->
    Ones = 1 bsl (floor(math:log(N, 2)) + 1) - 1,
    N bxor Ones.