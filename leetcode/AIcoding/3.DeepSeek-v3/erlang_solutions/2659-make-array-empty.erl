-spec count_operations_to_empty_array(Nums :: [integer()]) -> integer().
count_operations_to_empty_array(Nums) ->
    IndexMap = maps:from_list([{Num, Idx} || {Idx, Num} <- lists:zip(lists:seq(0, length(Nums) - 1), Nums)]),
    Sorted = lists:sort(Nums),
    Count = 0,
    PrevPos = 0,
    {Total, _} = lists:foldl(fun(Num, {Acc, Prev}) ->
        CurrentPos = maps:get(Num, IndexMap),
        if
            CurrentPos < Prev -> Acc + 1;
            true -> Acc
        end,
        {Acc + 1, CurrentPos}
    end, {Count, PrevPos}, Sorted),
    Total.