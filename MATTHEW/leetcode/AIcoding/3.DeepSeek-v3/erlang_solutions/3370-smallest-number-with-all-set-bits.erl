-spec smallest_num_with_all_set_bits(K :: integer()) -> integer().
smallest_num_with_all_set_bits(K) ->
    (1 bsl K) - 1.