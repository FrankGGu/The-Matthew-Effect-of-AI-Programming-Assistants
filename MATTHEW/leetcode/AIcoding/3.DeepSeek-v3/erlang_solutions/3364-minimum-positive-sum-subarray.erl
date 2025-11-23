-spec min_positive_sum_subarray(Nums :: [integer()]) -> integer().
min_positive_sum_subarray(Nums) ->
    {MinSum, _} = lists:foldl(fun(N, {CurrentMin, CurrentSum}) ->
        NewSum = if CurrentSum + N > 0 -> CurrentSum + N; true -> 0 end,
        NewMin = if NewSum > 0 andalso (CurrentMin =:= -1 orelse NewSum < CurrentMin) -> NewSum; true -> CurrentMin end,
        {NewMin, NewSum}
    end, {-1, 0}, Nums),
    if MinSum =:= -1 -> -1; true -> MinSum end.