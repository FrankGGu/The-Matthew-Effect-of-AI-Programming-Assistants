-module(solution).
-export([two_out_of_three/3]).

two_out_of_three(Nums1, Nums2, Nums3) ->
    Set1 = ordsets:from_list(Nums1),
    Set2 = ordsets:from_list(Nums2),
    Set3 = ordsets:from_list(Nums3),

    Intersection12 = ordsets:intersection(Set1, Set2),
    Intersection13 = ordsets:intersection(Set1, Set3),
    Intersection23 = ordsets:intersection(Set2, Set3),

    ResultUnion = ordsets:union(ordsets:union(Intersection12, Intersection13), Intersection23),

    ResultUnion.