-spec permute(Nums :: [integer()]) -> [[integer()]].
permute(Nums) ->
    permute(Nums, length(Nums)).

permute([], _) -> [[]];
permute(_, 0) -> [[]];
permute(Nums, K) ->
    [[X | Y] || X <- Nums, Y <- permute(lists:delete(X, Nums), K - 1)].