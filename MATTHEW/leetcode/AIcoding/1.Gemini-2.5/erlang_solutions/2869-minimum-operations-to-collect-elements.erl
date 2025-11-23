-module(solution).
-export([min_operations_to_collect_elements/2]).

min_operations_to_collect_elements(Nums, K) ->
    SortedNums = lists:reverse(lists:sort(Nums)),
    collect_elements(SortedNums, K, sets:new(), 0).

collect_elements([H|T], K, CollectedSet, Operations) ->
    NewOperations = Operations + 1,
    NewCollectedSet =
        if
            H >= 1 andalso H =< K andalso not sets:is_element(H, CollectedSet) ->
                sets:add_element(H, CollectedSet);
            true ->
                CollectedSet
        end,

    if
        sets:size(NewCollectedSet) == K ->
            NewOperations;
        true ->
            collect_elements(T, K, NewCollectedSet, NewOperations)
    end;
collect_elements([], _K, _CollectedSet, Operations) ->
    Operations.