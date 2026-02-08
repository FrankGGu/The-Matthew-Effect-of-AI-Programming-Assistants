-spec minimize_max_difference([integer()], integer()) -> integer().
minimize_max_difference(Nums, P) ->
    Sorted = lists:sort(Nums),
    Len = length(Sorted),
    if
        Len =< 1 -> 0;
        true ->
            {ok, DP} = array:new([{size, Len}, {default, 0}]),
            DP1 = array:set(0, 0, DP),
            DP2 = array:set(1, Sorted !! 1 - Sorted !! 0, DP1),
            DP3 = lists:foldl(fun(I, Acc) ->
                case I < P of
                    true -> array:set(I, Sorted !! I - Sorted !! 0, Acc);
                    false ->
                        Min = lists:min([max(array:get(I - K, Acc), Sorted !! I - Sorted !! (I - K + 1)] || K <- lists:seq(1, P)]),
                        array:set(I, Min, Acc)
                end
            end, DP2, lists:seq(2, Len - 1)),
            array:get(Len - 1, DP3)
    end.

!!(List, Index) ->
    lists:nth(Index + 1, List).