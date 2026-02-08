-module(subarray_distinct_element_sum_squares_i).
-export([distinct_element_sum_squares/1]).

distinct_element_sum_squares(Nums) ->
    distinct_element_sum_squares(Nums, 0).

distinct_element_sum_squares([], Acc) ->
    Acc;
distinct_element_sum_squares(Nums, Acc) ->
    distinct_element_sum_squares(Nums, 0, Acc).

distinct_element_sum_squares(_, Len, Acc) when Len > length(Nums) ->
    Acc;
distinct_element_sum_squares(Nums, Len, Acc) ->
    distinct_element_sum_squares(Nums, Len, 0, Acc).

distinct_element_sum_squares(Nums, Len, Start, Acc) when Start + Len > length(Nums) ->
    distinct_element_sum_squares(Nums, Len + 1, Acc);
distinct_element_sum_squares(Nums, Len, Start, Acc) ->
    Subarray = lists:sublist(Nums, Start + 1, Len),
    Distinct = lists:usort(Subarray),
    Sum = length(Distinct),
    distinct_element_sum_squares(Nums, Len, Start + 1, Acc + Sum * Sum).