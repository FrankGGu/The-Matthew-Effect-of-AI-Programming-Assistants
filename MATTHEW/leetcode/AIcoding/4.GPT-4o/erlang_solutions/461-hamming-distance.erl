-module(solution).
-export([hamming_distance/2]).

-spec hamming_distance(integer(), integer()) -> integer().
hamming_distance(X, Y) ->
    %% XOR the two numbers to get differing bit positions
    DiffBits = X bxor Y,
    %% Count the number of 1s in the result using a bit counting function
    count_ones(DiffBits).

%% Helper function to count the number of 1s in a binary number.
count_ones(0) -> 0;
count_ones(N) -> (N band 1) + count_ones(N bsr 1).
