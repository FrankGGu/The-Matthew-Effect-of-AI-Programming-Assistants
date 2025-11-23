-module(solution).
-export([find_common_elements/2]).

find_common_elements(Nums1, Nums2) ->
    Set1 = sets:from_list(Nums1),
    Set2 = sets:from_list(Nums2),

    Count1 = count_elements_in_set(Nums1, Set2),
    Count2 = count_elements_in_set(Nums2, Set1),

    [Count1, Count2].

count_elements_in_set(List, Set) ->
    lists:foldl(fun(E, Acc) ->
                    case sets:is_element(E, Set) of
                        true -> Acc + 1;
                        false -> Acc
                    end
                end, 0, List).