-spec xor_all_nums(Nums1 :: [integer()], Nums2 :: [integer()]) -> integer().
xor_all_nums(Nums1, Nums2) ->
    Len1 = length(Nums1),
    Len2 = length(Nums2),
    Xor1 = lists:foldl(fun(X, Acc) -> X bxor Acc end, 0, Nums1),
    Xor2 = lists:foldl(fun(X, Acc) -> X bxor Acc end, 0, Nums2),
    if
        Len1 rem 2 == 1 andalso Len2 rem 2 == 1 -> Xor1 bxor Xor2;
        Len1 rem 2 == 1 -> Xor2;
        Len2 rem 2 == 1 -> Xor1;
        true -> 0
    end.