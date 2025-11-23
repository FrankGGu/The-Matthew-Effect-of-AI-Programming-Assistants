-spec min_operations(Nums :: [integer()]) -> integer().
min_operations(Nums) ->
    lists:sum([case Num rem 3 of
                    0 -> 0;
                    1 -> 1;
                    2 -> 2
                end || Num <- Nums]).