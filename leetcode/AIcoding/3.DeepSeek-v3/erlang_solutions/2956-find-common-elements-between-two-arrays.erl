-spec find_intersection_values(Nums1 :: [integer()], Nums2 :: [integer()]) -> [integer()].
find_intersection_values(Nums1, Nums2) ->
    Set1 = sets:from_list(Nums1),
    Set2 = sets:from_list(Nums2),
    Count1 = count_common_elements(Nums1, Set2),
    Count2 = count_common_elements(Nums2, Set1),
    [Count1, Count2].

count_common_elements(List, Set) ->
    lists:foldl(fun(X, Acc) -> 
        case sets:is_element(X, Set) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, List).