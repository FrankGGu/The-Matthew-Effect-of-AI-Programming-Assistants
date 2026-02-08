-spec min_count(Coins :: [integer()]) -> integer().
min_count(Coins) ->
    lists:sum([(X + 1) div 2 || X <- Coins]).