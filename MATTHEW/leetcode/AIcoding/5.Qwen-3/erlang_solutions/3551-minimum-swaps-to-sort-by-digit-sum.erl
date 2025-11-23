-module(min_swaps_to_sort_by_digit_sum).
-export([minSwaps/1]).

minSwaps(List) ->
    Sorted = lists:sort(List),
    IndexMap = maps:from_list([{Val, I} || {I, Val} <- lists:enumerate(1, List)]),
    Visited = sets:new(),
    Swaps = 0,
    loop(List, Sorted, IndexMap, Visited, Swaps).

loop([], _, _, _, Swaps) ->
    Swaps;
loop([Current | Rest], Sorted, IndexMap, Visited, Swaps) ->
    case sets:is_element(Current, Visited) of
        true ->
            loop(Rest, Sorted, IndexMap, Visited, Swaps);
        false ->
            Next = maps:get(Current, IndexMap),
            NewVisited = sets:add_element(Current, Visited),
            loop([Current | Rest], Sorted, IndexMap, NewVisited, Swaps + 1)
    end.