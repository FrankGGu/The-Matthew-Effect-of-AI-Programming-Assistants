-spec longest_increasing_path(Matrix :: [[integer()]]) -> integer().
longest_increasing_path(Matrix) ->
    lists:max(lists:map(fun(Row) -> length(Row) end, Matrix)).
