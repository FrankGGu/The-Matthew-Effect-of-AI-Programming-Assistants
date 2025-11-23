-spec minimize_array_value(Nums :: [integer()]) -> integer().
minimize_array_value(Nums) ->
    lists:foldl(fun(X, {Sum, Res}) ->
        NewSum = Sum + X,
        NewRes = max(Res, (NewSum + length(Nums) - 1) div length(Nums)),
        {NewSum, NewRes}
    end, {0, 0}, Nums),
    element(2, lists:foldl(fun(X, {Sum, Res}) ->
        NewSum = Sum + X,
        NewRes = max(Res, (NewSum + (length(Nums) - 1)) div length(Nums)),
        {NewSum, NewRes}
    end, {0, 0}, Nums)).