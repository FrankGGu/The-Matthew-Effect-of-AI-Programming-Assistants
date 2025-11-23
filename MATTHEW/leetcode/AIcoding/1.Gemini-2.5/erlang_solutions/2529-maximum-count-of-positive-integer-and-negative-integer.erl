-spec maximum_count(Nums :: [integer()]) -> integer().
maximum_count(Nums) ->
    {NegCount, PosCount} = lists:foldl(fun(X, {NC, PC}) ->
                                            if X < 0 -> {NC + 1, PC};
                                               X > 0 -> {NC, PC + 1};
                                               true -> {NC, PC}
                                            end
                                    end, {0, 0}, Nums),
    max(NegCount, PosCount).