-spec sum_indices_with_k_set_bits(Nums :: [integer()], K :: integer()) -> integer().
sum_indices_with_k_set_bits(Nums, K) ->
    lists:sum([Num || {Num, I} <- lists:zip(Nums, lists:seq(0, length(Nums) - 1)), 
                      count_set_bits(I) =:= K]).

count_set_bits(N) ->
    count_set_bits(N, 0).

count_set_bits(0, Count) -> Count;
count_set_bits(N, Count) ->
    count_set_bits(N bsr 1, Count + (N band 1)).