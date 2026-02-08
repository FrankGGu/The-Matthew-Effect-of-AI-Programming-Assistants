-spec hamming_weight(N :: non_neg_integer()) -> integer().
hamming_weight(N) ->
    hamming_weight(N, 0).

hamming_weight(0, Count) ->
    Count;
hamming_weight(N, Count) ->
    hamming_weight(N band (N - 1), Count + 1).