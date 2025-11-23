-spec matrix_sum(Matrix :: [[integer()]]) -> integer().
matrix_sum(Matrix) ->
    SortedRows = [lists:sort(Row) || Row <- Matrix],
    Transposed = transpose(SortedRows),
    lists:sum([lists:max(Col) || Col <- Transposed]).

transpose([[]|_]) -> [];
transpose(M) ->
    [lists:map(fun hd/1, M) | transpose(lists:map(fun tl/1, M))].