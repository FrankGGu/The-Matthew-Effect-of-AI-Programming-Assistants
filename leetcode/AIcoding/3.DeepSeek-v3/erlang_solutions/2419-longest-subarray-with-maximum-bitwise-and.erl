-spec longest_subarray(Nums :: [integer()]) -> integer().
longest_subarray(Nums) ->
    Max = lists:max(Nums),
    lists:foldl(fun(X, {Current, MaxLen}) ->
                    if
                        X == Max -> {Current + 1, max(Current + 1, MaxLen)};
                        true -> {0, MaxLen}
                    end
                end, {0, 0}, Nums),
    element(2, lists:foldl(fun(X, {Current, MaxLen}) ->
                    if
                        X == Max -> {Current + 1, max(Current + 1, MaxLen)};
                        true -> {0, MaxLen}
                    end
                end, {0, 0}, Nums)).