-spec number_of_pairs(Nums1 :: [integer()], Nums2 :: [integer()], K :: integer()) -> integer().
number_of_pairs(Nums1, Nums2, K) ->
    Freq = maps:new(),
    Freq1 = lists:foldl(fun(Num, Acc) ->
        Key = Num * K,
        maps:update_with(Key, fun(V) -> V + 1 end, 1, Acc)
    end, Freq, Nums2),
    lists:foldl(fun(Num, Acc) ->
        case Num rem K of
            0 ->
                Key = Num div K,
                Acc + maps:get(Key, Freq1, 0);
            _ -> Acc
        end
    end, 0, Nums1).