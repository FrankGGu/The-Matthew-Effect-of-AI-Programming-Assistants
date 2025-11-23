-spec permute_unique(Nums :: [integer()]) -> [[integer()]].
permute_unique(Nums) ->
    lists:usort(permute(lists:sort(Nums))).

permute([]) -> [[]];
permute(L) ->
    [[H|T] || H <- L, T <- permute(L -- [H])].