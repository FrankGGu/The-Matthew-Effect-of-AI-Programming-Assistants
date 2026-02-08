-spec difference_of_distinct_values(Matrix :: [[integer()]]) -> [[integer()]].
difference_of_distinct_values(Matrix) ->
    M = length(Matrix),
    case M of
        0 -> [];
        _ ->
            N = length(hd(Matrix)),
            [[calculate_diff(Matrix, I, J, M, N) || J <- lists:seq(0, N-1)] || I <- lists:seq(0, M-1)]
    end.

calculate_diff(Matrix, I, J, M, N) ->
    TopLeft = count_distinct(Matrix, I, J, -1, -1, M, N),
    BottomRight = count_distinct(Matrix, I, J, 1, 1, M, N),
    abs(TopLeft - BottomRight).

count_distinct(Matrix, I, J, Di, Dj, M, N) ->
    count_distinct(Matrix, I + Di, J + Dj, Di, Dj, M, N, sets:new()).

count_distinct(Matrix, I, J, Di, Dj, M, N, Set) ->
    if
        I >= 0, I < M, J >= 0, J < N ->
            Value = lists:nth(J + 1, lists:nth(I + 1, Matrix)),
            NewSet = sets:add_element(Value, Set),
            count_distinct(Matrix, I + Di, J + Dj, Di, Dj, M, N, NewSet);
        true ->
            sets:size(Set)
    end.