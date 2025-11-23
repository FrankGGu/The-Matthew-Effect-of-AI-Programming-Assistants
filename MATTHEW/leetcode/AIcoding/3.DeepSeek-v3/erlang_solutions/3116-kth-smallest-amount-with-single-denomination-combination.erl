-spec kth_smallest(Matrix :: [[integer()]], K :: integer()) -> integer().
kth_smallest(Matrix, K) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Min = hd(hd(Matrix)),
    Max = lists:last(lists:last(Matrix)),
    binary_search(Matrix, Min, Max, K, Rows, Cols).

binary_search(Matrix, Min, Max, K, Rows, Cols) ->
    if
        Min == Max -> Min;
        true ->
            Mid = (Min + Max) div 2,
            Count = count_less_equal(Matrix, Mid, Rows, Cols),
            if
                Count < K ->
                    binary_search(Matrix, Mid + 1, Max, K, Rows, Cols);
                true ->
                    binary_search(Matrix, Min, Mid, K, Rows, Cols)
            end
    end.

count_less_equal(Matrix, Target, Rows, Cols) ->
    count_less_equal(Matrix, Target, Rows, Cols, 0, 0, 0).

count_less_equal(Matrix, Target, Rows, Cols, I, J, Count) ->
    if
        I >= Rows -> Count;
        J >= Cols -> count_less_equal(Matrix, Target, Rows, Cols, I + 1, 0, Count);
        true ->
            case lists:nth(J + 1, lists:nth(I + 1, Matrix)) of
                Val when Val =< Target ->
                    count_less_equal(Matrix, Target, Rows, Cols, I, J + 1, Count + 1);
                _ ->
                    count_less_equal(Matrix, Target, Rows, Cols, I + 1, 0, Count)
            end
    end.