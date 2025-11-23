-spec count_negatives(Grid :: [[integer()]]) -> integer().
count_negatives(Grid) ->
    lists:sum([lists:sum([1 || X <- Row, X < 0]) || Row <- Grid]).