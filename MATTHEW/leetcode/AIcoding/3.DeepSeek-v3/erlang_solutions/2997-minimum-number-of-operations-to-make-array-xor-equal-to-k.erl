-spec min_operations(Nums :: [integer()], K :: integer()) -> integer().
min_operations(Nums, K) ->
    Xor = lists:foldl(fun(N, Acc) -> Acc bxor N end, 0, Nums),
    Diff = Xor bxor K,
    count_bits(Diff).

count_bits(0) -> 0;
count_bits(N) -> 
    (N band 1) + count_bits(N bsr 1).