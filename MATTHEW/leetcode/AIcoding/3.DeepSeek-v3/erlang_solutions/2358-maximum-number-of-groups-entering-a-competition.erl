-spec maximum_groups(Grades :: [integer()]) -> integer().
maximum_groups(Grades) ->
    N = length(Grades),
    K = trunc((math:sqrt(8 * N + 1) - 1) / 2),
    K.