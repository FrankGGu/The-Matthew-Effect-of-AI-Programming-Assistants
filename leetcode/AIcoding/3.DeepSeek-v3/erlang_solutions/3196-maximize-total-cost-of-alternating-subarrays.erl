-spec max_total_cost(Nums :: [integer()]) -> integer().
max_total_cost(Nums) ->
    {A, B} = lists:foldl(fun(X, {PrevA, PrevB}) ->
        NewA = max(PrevB + X, X),
        NewB = PrevA - X,
        {NewA, NewB}
    end, {0, 0}, Nums),
    max(A, B).