-spec four_sum_count(Nums1 :: [integer()], Nums2 :: [integer()], Nums3 :: [integer()], Nums4 :: [integer()]) -> integer().
four_sum_count(Nums1, Nums2, Nums3, Nums4) ->
    Map = maps:new(),
    Map1 = lists:foldl(fun(A, Acc) ->
        lists:foldl(fun(B, InnerAcc) ->
            Sum = A + B,
            maps:update_with(Sum, fun(V) -> V + 1 end, 1, InnerAcc)
        end, Acc, Nums2)
    end, Map, Nums1),
    lists:foldl(fun(C, Acc) ->
        lists:foldl(fun(D, InnerAcc) ->
            Sum = C + D,
            case maps:get(-Sum, Map1, 0) of
                0 -> InnerAcc;
                V -> InnerAcc + V
            end
        end, Acc, Nums4)
    end, 0, Nums3).