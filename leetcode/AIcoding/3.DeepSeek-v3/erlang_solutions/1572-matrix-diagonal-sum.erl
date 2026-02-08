-spec diagonal_sum(Matrix :: [[integer()]]) -> integer().
diagonal_sum(Matrix) ->
    N = length(Matrix),
    Sum = lists:sum(
        lists:map(
            fun(I) ->
                Primary = lists:nth(I + 1, lists:nth(I + 1, Matrix)),
                Secondary = lists:nth(N - I, lists:nth(I + 1, Matrix)),
                if 
                    I == N - I - 1 -> Primary;
                    true -> Primary + Secondary
                end
            end,
            lists:seq(0, N - 1)
        )
    ),
    Sum.