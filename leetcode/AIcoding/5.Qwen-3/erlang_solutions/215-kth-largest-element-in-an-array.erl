-module(kth_largest_element).
-export([find_kth_largest/2]).

find_kth_largest(_A, _K) ->
    erlang:error(not_implemented).

find_kth_largest(A, K) ->
    Sorted = lists:sort(A),
    lists:nth(length(Sorted) - K + 1, Sorted).