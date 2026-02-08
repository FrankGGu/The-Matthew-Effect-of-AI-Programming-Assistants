-module(solution).
-export([next_greater_element/2]).

next_greater_element(Nums1, Nums2) ->
    Map = maps:from_list([{Num, Index} || {Index, Num} <- lists:zip(lists:seq(0, length(Nums2)-1), Nums2)]),
    [next_greater_element_helper(Num, Nums2, Map) || Num <- Nums1].

next_greater_element_helper(Num, Nums2, Map) ->
    Index = maps:get(Num, Map),
    NextGreater = next_greater_element_helper(Num, Nums2, Index + 1, length(Nums2)),
    NextGreater.

next_greater_element_helper(_, _, Index, Max) when Index >= Max ->
    -1;
next_greater_element_helper(Num, Nums2, Index, _) ->
    Case = lists:nth(Index, Nums2),
    if
        Case > Num -> Case;
        true -> next_greater_element_helper(Num, Nums2, Index + 1, length(Nums2))
    end.