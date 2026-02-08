-spec rotate(matrix :: [[integer()]]) -> [[integer()]].
rotate(Matrix) ->
    N = length(Matrix),
    Transposed = transpose(Matrix, N),
    reverse_rows(Transposed, N).

transpose(Matrix, N) ->
    [[lists:nth(J, lists:nth(I, Matrix)) || J <- lists:seq(1, N)] || I <- lists:seq(1, N)].

reverse_rows(Matrix, N) ->
    [lists:reverse(Row) || Row <- Matrix].