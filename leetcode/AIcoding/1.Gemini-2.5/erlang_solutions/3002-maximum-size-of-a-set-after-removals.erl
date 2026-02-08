-module(solution).
-export([maximum_set_size/2]).

maximum_set_size(Nums1, Nums2) ->
    N = length(Nums1),

    Set1 = sets:from_list(Nums1),
    Set2 = sets:from_list(Nums2),

    UnionSet = sets:union(Set1, Set2),
    UnionSize = sets:size(UnionSet),

    min(N, UnionSize).