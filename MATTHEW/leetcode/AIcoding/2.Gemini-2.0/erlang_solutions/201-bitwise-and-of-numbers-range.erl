-module(bitwise_and_range).
-export([range_bitwise_and/2]).

range_bitwise_and(M, N) when M == N ->
    M;
range_bitwise_and(M, N) ->
    range_bitwise_and_helper(M, N, 0).

range_bitwise_and_helper(M, N, Shift) when M == N ->
    M bsl Shift;
range_bitwise_and_helper(M, N, Shift) when M > N ->
    0;
range_bitwise_and_helper(M, N, Shift) ->
    range_bitwise_and_helper(M bsr 1, N bsr 1, Shift + 1).