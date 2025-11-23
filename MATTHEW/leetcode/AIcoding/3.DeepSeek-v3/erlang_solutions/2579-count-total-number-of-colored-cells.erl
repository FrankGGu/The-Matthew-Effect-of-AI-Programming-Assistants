-spec colored_cells(N :: integer()) -> integer().
colored_cells(N) ->
    N * N + (N - 1) * (N - 1).