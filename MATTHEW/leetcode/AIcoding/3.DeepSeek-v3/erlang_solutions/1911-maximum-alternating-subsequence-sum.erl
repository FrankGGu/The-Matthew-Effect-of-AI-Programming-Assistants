-spec max_alternating_sum(Nums :: [integer()]) -> integer().
max_alternating_sum(Nums) ->
    {Even, Odd} = lists:foldl(fun
        (Num, {E, O}) ->
            NewE = max(E, O - Num),
            NewO = max(O, E + Num),
            {NewE, NewO}
    end, {0, 0}, Nums),
    max(Even, Odd).