-spec hamming_distance(X :: integer(), Y :: integer()) -> integer().
hamming_distance(X, Y) ->
    Z = X bxor Y,
    count_ones(Z).

count_ones(0) -> 0;
count_ones(N) ->
    (N band 1) + count_ones(N bsr 1).