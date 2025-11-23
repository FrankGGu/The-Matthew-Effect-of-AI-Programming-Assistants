-module(solution).
-export([relativeSortArray/2]).

relativeSortArray(Arr1, Arr2) ->
    FreqMap = lists:foldl(fun(E, Acc) ->
                                  maps:update_with(E, fun(V) -> V + 1 end, 1, Acc)
                          end, maps:new(), Arr1),

    {SortedPartRev, RemainingFreqMap} = lists:foldl(fun(E, {AccList, AccMap}) ->
                                                            Count = maps:get(E, AccMap),
                                                            NewAccList = append_n_times(E, Count, AccList),
                                                            NewAccMap = maps:remove(E, AccMap),
                                                            {NewAccList, NewAccMap}
                                                    end, {[], FreqMap}, Arr2),

    RemainingElementsRev = maps:fold(fun(K, V, Acc) ->
                                             append_n_times(K, V, Acc)
                                     end, [], RemainingFreqMap),

    SortedRemaining = lists:sort(RemainingElementsRev),

    lists:reverse(SortedPartRev) ++ SortedRemaining.

append_n_times(Elem, N, AccList) when N > 0 ->
    append_n_times(Elem, N - 1, [Elem | AccList]);
append_n_times(_, 0, AccList) ->
    AccList.