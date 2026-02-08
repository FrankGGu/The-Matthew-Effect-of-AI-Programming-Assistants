-spec min_start_value(Nums :: [integer()]) -> integer().
min_start_value(Nums) ->
    {Min, _} = lists:foldl(fun(X, {CurrentMin, Sum}) ->
        NewSum = Sum + X,
        NewMin = min(CurrentMin, NewSum),
        {NewMin, NewSum}
    end, {0, 0}, Nums),
    case Min >= 0 of
        true -> 1;
        false -> 1 - Min
    end.