-spec total_hamming_distance(Nums :: [integer()]) -> integer().
total_hamming_distance(Nums) ->
    Bits = lists:seq(0, 31),
    lists:sum([count_bits(Nums, Bit) * (length(Nums) - count_bits(Nums, Bit)) || Bit <- Bits]).

count_bits(Nums, Bit) ->
    lists:foldl(fun(Num, Acc) ->
        case (Num bsr Bit) band 1 of
            1 -> Acc + 1;
            0 -> Acc
        end
    end, 0, Nums).