-spec hamming_weight(N :: integer()) -> integer().
hamming_weight(N) ->
    hamming_weight(N, 0).

hamming_weight(0, Count) -> Count;
hamming_weight(N, Count) when N band 1 =:= 1 -> 
    hamming_weight(N bsr 1, Count + 1);
hamming_weight(N, Count) -> 
    hamming_weight(N bsr 1, Count).
