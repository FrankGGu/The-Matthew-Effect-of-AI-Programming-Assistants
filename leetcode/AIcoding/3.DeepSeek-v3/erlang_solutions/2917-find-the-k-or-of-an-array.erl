-spec k_or(Nums :: [integer()], K :: integer()) -> integer().
k_or(Nums, K) ->
    Bits = lists:seq(0, 31),
    lists:foldl(fun(Bit, Acc) ->
        Count = lists:foldl(fun(Num, Cnt) ->
            case (Num bsr Bit) band 1 of
                1 -> Cnt + 1;
                0 -> Cnt
            end
        end, 0, Nums),
        if
            Count >= K -> Acc bor (1 bsl Bit);
            true -> Acc
        end
    end, 0, Bits).