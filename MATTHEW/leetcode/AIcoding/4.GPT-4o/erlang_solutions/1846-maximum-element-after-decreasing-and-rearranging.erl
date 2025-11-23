-module(solution).
-export([maximum_element_after_decreasing_and_rearranging/1]).

maximum_element_after_decreasing_and_rearranging(A) ->
    Sorted = lists:sort(A),
    Max = lists:foldl(fun (X, Acc) -> min(X, Acc + 1) end, 0, Sorted).