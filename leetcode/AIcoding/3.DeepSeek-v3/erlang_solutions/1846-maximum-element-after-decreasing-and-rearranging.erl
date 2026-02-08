-spec maximum_element_after_decrementing_and_rearranging(Arr :: [integer()]) -> integer().
maximum_element_after_decrementing_and_rearranging(Arr) ->
    Sorted = lists:sort(Arr),
    maximum_element_after_decrementing_and_rearranging(Sorted, 1, 0).

maximum_element_after_decrementing_and_rearranging([], Prev, Max) ->
    Max;
maximum_element_after_decrementing_and_rearranging([H | T], Prev, Max) ->
    NewVal = min(H, Prev + 1),
    maximum_element_after_decrementing_and_rearranging(T, NewVal, max(NewVal, Max)).