-spec count_smaller(Nums :: [integer()]) -> [integer()].
count_smaller(Nums) ->
    Indices = lists:seq(0, length(Nums) - 1),
    {_, Result} = merge_sort(lists:zip(Nums, Indices),
    Result.

merge_sort(List) ->
    case List of
        [] -> {[], []};
        [X] -> {[X], [0]};
        _ ->
            {Left, Right} = lists:split(length(List) div 2, List),
            {SortedLeft, CountsLeft} = merge_sort(Left),
            {SortedRight, CountsRight} = merge_sort(Right),
            merge(SortedLeft, CountsLeft, SortedRight, CountsRight, [], [], 0)
    end.

merge([], [], Right, CountsRight, Merged, Counts, _) ->
    {lists:reverse(Merged) ++ Right, lists:reverse(Counts) ++ CountsRight};
merge(Left, CountsLeft, [], [], Merged, Counts, _) ->
    {lists:reverse(Merged) ++ Left, lists:reverse(Counts) ++ CountsLeft};
merge([{Num, Index} | LeftRest], [Count | CountsLeftRest], [{RightNum, RightIndex} | RightRest] = Right, [RightCount | RightCountsRest] = RightCounts, Merged, Counts, Smaller) ->
    if
        Num =< RightNum ->
            merge(LeftRest, CountsLeftRest, Right, RightCounts, [{Num, Index} | Merged], [Count + Smaller | Counts], Smaller);
        true ->
            merge([{Num, Index} | LeftRest], [Count | CountsLeftRest], RightRest, RightCountsRest, [{RightNum, RightIndex} | Merged], [RightCount | Counts], Smaller + 1)
    end.