-module(max_element_after_decreasing_and_rearranging).
-export([maximum_element/1]).

maximum_element(Arr) ->
    Sorted = lists:sort(Arr),
    lists:foldl(fun(Elem, Acc) ->
        if
            Elem > Acc -> Elem;
            true -> Acc
        end
    end, 0, Sorted).