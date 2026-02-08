-module(solution).
-export([range_sum/3]).

range_sum(A, L, R) ->
    SortedSums = lists:sort([X + Y || X <- A, Y <- A]),
    sum_range(SortedSums, L, R).

sum_range(SortedSums, L, R) ->
    lists:sum(lists:sublist(SortedSums, L - 1, R - L + 1)).