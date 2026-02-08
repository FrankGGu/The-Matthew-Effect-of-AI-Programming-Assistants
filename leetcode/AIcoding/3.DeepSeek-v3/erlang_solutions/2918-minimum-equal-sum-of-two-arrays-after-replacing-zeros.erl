-spec min_sum(Nums1 :: [integer()], Nums2 :: [integer()]) -> integer().
min_sum(Nums1, Nums2) ->
    Sum1 = lists:sum(Nums1),
    Sum2 = lists:sum(Nums2),
    Count1 = lists:foldl(fun(X, Acc) -> if X == 0 -> Acc + 1; true -> Acc end end, 0, Nums1),
    Count2 = lists:foldl(fun(X, Acc) -> if X == 0 -> Acc + 1; true -> Acc end end, 0, Nums2),
    case {Count1, Count2} of
        {0, 0} ->
            if Sum1 == Sum2 -> Sum1; true -> -1 end;
        _ ->
            if Count1 == 0 andalso Sum1 < Sum2 + Count2 -> -1;
               Count2 == 0 andalso Sum2 < Sum1 + Count1 -> -1;
               true ->
                   Max1 = max(Sum1 + Count1, Sum2 + Count2),
                   Max2 = max(Sum2 + Count2, Sum1 + Count1),
                   max(Max1, Max2)
            end
    end.