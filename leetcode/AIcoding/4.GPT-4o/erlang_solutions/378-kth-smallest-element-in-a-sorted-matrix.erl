-spec kth_smallest(Matrix :: [[integer()]], K :: integer()) -> integer().
kth_smallest(Matrix, K) ->
    flatten(Matrix)
    |> lists:sort()
    |> lists:nth(K).
