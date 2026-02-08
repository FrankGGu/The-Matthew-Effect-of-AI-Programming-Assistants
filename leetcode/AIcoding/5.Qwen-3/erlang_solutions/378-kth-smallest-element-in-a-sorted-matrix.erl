-module(kth_smallest_element_in_a_sorted_matrix).
-export([kthSmallest/2]).

kthSmallest(Matrix, K) ->
    List = lists:flatten(Matrix),
    Sorted = lists:sort(List),
    lists:nth(K, Sorted).