-module(solution).
-export([minimum_one_bit_operations/1]).

minimum_one_bit_operations(N) when N < 0 -> 0;
minimum_one_bit_operations(0) -> 0;
minimum_one_bit_operations(N) -> minimum_one_bit_operations_helper(N, 0).

minimum_one_bit_operations_helper(0, Count) -> Count;
minimum_one_bit_operations_helper(N, Count) ->
    NewN = N bor (N bsr 1),
    minimum_one_bit_operations_helper(NewN, Count + 1).