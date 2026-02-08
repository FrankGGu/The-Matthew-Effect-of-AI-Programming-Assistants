-module(maximum_element_after_decreasing_and_rearranging).
-export([maximum_element_after_decreasing_and_rearranging/1]).

maximum_element_after_decreasing_and_rearranging(Arr) ->
    SortedArr = lists:sort(Arr),
    maximum_element_after_decreasing_and_rearranging_helper(SortedArr, 1).

maximum_element_after_decreasing_and_rearranging_helper([], Max) ->
    Max;
maximum_element_after_decreasing_and_rearranging_helper([H|T], Max) ->
    NewMax = min(H, Max + 1),
    maximum_element_after_decreasing_and_rearranging_helper(T, NewMax).