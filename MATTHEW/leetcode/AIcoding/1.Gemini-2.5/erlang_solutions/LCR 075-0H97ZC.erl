-module(solution).
-export([relative_sort_array/2]).

relative_sort_array(Arr1, Arr2) ->
    FreqMap = lists:foldl(fun(X, Map) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Map) end, #{}, Arr1),

    {ResultPart1, UpdatedFreqMap} = lists:foldl(
        fun(X, {AccList, AccMap}) ->
            Count = maps:get(X, AccMap, 0),
            NewAccList = lists:append(AccList, lists:duplicate(Count, X)),
            NewAccMap = maps:remove(X, AccMap),
            {NewAccList, NewAccMap}
        end, {[], FreqMap}, Arr2),

    RemainingElements = lists:foldl(
        fun({K, V}, Acc) ->
            lists:append(Acc, lists:duplicate(V, K))
        end, [], maps:to_list(UpdatedFreqMap)),

    SortedRemaining = lists:sort(RemainingElements),

    lists:append(ResultPart1, SortedRemaining).