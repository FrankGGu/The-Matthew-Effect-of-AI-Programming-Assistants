-spec min_moves(Nums :: [integer()]) -> integer().
min_moves(Nums) ->
    Min = lists:min(Nums),
    lists:sum([Num - Min || Num <- Nums]).