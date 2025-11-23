-spec find_median_sorted_arrays(Nums1 :: [integer()], Nums2 :: [integer()]) -> float().
find_median_sorted_arrays(Nums1, Nums2) ->
    merge_and_find_median(Nums1 ++ Nums2).

merge_and_find_median(Sorted) ->
    Length = length(Sorted),
    case Length rem 2 of
        0 -> 
            Mid1 = div(Length, 2) - 1,
            Mid2 = div(Length, 2),
            (lists:nth(Mid1 + 1, Sorted) + lists:nth(Mid2 + 1, Sorted)) / 2.0;
        1 -> 
            Mid = div(Length, 2),
            lists:nth(Mid + 1, Sorted) * 1.0
    end.
