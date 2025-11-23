-module(intersection).
-export([intersection/2]).

intersection(Nums1, Nums2) ->
  Set1 = list_to_ordset(Nums1),
  Set2 = list_to_ordset(Nums2),
  ordsets:intersection(Set1, Set2).