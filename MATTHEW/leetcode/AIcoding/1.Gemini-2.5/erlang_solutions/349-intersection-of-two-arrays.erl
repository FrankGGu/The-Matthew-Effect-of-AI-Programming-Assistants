-module(solution).
-export([intersection/2]).

intersection(Nums1, Nums2) ->
    Set1 = sets:from_list(Nums1),
    Set2 = sets:from_list(Nums2),
    IntersectionSet = sets:intersection(Set1, Set2),
    sets:to_list(IntersectionSet).