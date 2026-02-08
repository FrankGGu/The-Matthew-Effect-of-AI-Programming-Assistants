-module(common_elements).
-export([intersect/2]).

intersect(Nums1, Nums2) ->
  Nums1Set = sets:from_list(Nums1),
  Nums2Set = sets:from_list(Nums2),
  CommonSet = sets:intersection(Nums1Set, Nums2Set),
  sets:to_list(CommonSet).