-spec maximum_groups(Grades :: [integer()]) -> integer().
maximum_groups(Grades) ->
    N = length(Grades),
    K_float = (-1 + math:sqrt(1 + 8 * N)) / 2,
    trunc(K_float).