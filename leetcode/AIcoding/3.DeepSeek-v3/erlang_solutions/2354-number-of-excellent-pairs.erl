-spec count_excellent_pairs(Nums :: [integer()], K :: integer()) -> integer().
count_excellent_pairs(Nums, K) ->
    UniqueNums = lists:usort(Nums),
    BitCounts = lists:foldl(fun(Num, Acc) ->
        Count = count_bits(Num),
        maps:update_with(Count, fun(V) -> V + 1 end, 1, Acc)
    end, #{}, UniqueNums),
    Counts = maps:to_list(BitCounts),
    lists:foldl(fun({A, C1}, Sum) ->
        lists:foldl(fun({B, C2}, InnerSum) ->
            case A + B >= K of
                true -> InnerSum + C1 * C2;
                false -> InnerSum
            end
        end, Sum, Counts)
    end, 0, Counts).

count_bits(N) ->
    count_bits(N, 0).

count_bits(0, Count) -> Count;
count_bits(N, Count) ->
    count_bits(N bsr 1, Count + (N band 1)).