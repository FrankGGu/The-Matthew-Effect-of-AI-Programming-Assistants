-module(two_out_of_three).
-export([two_out_of_three/3]).

two_out_of_three(Nums1, Nums2, Nums3) ->
  Set1 = sets:from_list(Nums1),
  Set2 = sets:from_list(Nums2),
  Set3 = sets:from_list(Nums3),
  Intersection12 = sets:to_list(sets:intersection(Set1, Set2)),
  Intersection13 = sets:to_list(sets:intersection(Set1, Set3)),
  Intersection23 = sets:to_list(sets:intersection(Set2, Set3)),
  UnionSets = lists:usort(Intersection12 ++ Intersection13 ++ Intersection23),
  lists:sort(lists:foldl(fun(X, Acc) ->
                                 Count = (lists:member(X, sets:to_list(Set1)) +
                                          lists:member(X, sets:to_list(Set2)) +
                                          lists:member(X, sets:to_list(Set3))),
                                 case Count >= 2 of
                                   true -> [X | Acc];
                                   false -> Acc
                                 end
                         end, [], UnionSets)).