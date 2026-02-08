-spec num_equiv_domino_pairs(Dominoes :: [[integer()]]) -> integer().
num_equiv_domino_pairs(Dominoes) ->
    CountMap = lists:foldl(fun([A, B], Acc) ->
                               Key = {min(A, B), max(A, B)},
                               maps:update_with(Key, fun(V) -> V + 1 end, 1, Acc)
                           end, #{}, Dominoes),
    lists:foldl(fun(V, Sum) -> Sum + V * (V - 1) div 2 end, 0, maps:values(CountMap)).