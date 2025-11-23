-module(solution).
-export([min_bit_changes/2]).

min_bit_changes(N, K) when (N band K) == K ->
    % If (N band K) == K, it means that for every bit position where K has a 1,
    % N also has a 1. This is a necessary condition for N to be transformable
    % into K by only changing 1s to 0s.
    % The number of changes required is the count of bits where N has a 1 and K has a 0.
    % This is equivalent to counting the set bits in (N bxor K).
    X = N bxor K,
    count_set_bits(X);
min_bit_changes(_N, _K) ->
    % If (N band K) != K, it means there is at least one bit position where
    % K has a 1 but N has a 0. Since we can only change 1s to 0s, we cannot
    % change a 0 in N to a 1 to match K. Thus, it's impossible.
    -1.

count_set_bits(0) -> 0;
count_set_bits(N) ->
    1 + count_set_bits(N band (N - 1)).