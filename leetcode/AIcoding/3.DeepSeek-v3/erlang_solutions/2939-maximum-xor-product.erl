-module(solution).
-export([maximum_xor_product/3]).

maximum_xor_product(A, B, N) ->
    Max = (1 bsl N) - 1,
    MaxXor = (A bxor Max) * (B bxor Max),
    MaxXor.