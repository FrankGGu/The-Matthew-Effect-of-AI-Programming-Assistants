-spec permute(Nums :: [integer()]) -> [[integer()]].
permute(Nums) -> 
    permute(Nums, []).

permute([], Acc) -> [Acc];
permute([H|T], Acc) ->
    lists:foldl(fun(X, Acc1) -> permute(T, [H | X] ++ Acc1) end, [], Acc).
