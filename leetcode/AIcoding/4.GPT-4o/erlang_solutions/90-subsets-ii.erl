-spec subsets_with_dup(Nums :: [integer()]) -> [[integer()]].
subsets_with_dup(Nums) ->
    lists:foldl(fun(X, Acc) ->
                    lists:usort([X | Acc]) 
                end, [[]], Nums).
