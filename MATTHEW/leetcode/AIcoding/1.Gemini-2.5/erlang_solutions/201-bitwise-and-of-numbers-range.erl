-module(solution).
-export([range_bitwise_and/2]).

range_bitwise_and(M, N) ->
    range_bitwise_and_recursive(M, N, 0).

range_bitwise_and_recursive(M, N, Count) when M == N ->
    M bsl Count;
range_bitwise_and_recursive(M, N, Count) ->
    range_bitwise_and_recursive(M bsr 1, N bsr 1, Count + 1).