-spec max_absolute_sum(Nums :: [integer()]) -> integer().
max_absolute_sum(Nums) ->
    {Max, Min, Res} = lists:foldl(fun(X, {CurrentMax, CurrentMin, CurrentRes}) ->
        NewMax = max(X, CurrentMax + X),
        NewMin = min(X, CurrentMin + X),
        NewRes = max(CurrentRes, max(abs(NewMax), abs(NewMin))),
        {NewMax, NewMin, NewRes}
    end, {0, 0, 0}, Nums),
    Res.