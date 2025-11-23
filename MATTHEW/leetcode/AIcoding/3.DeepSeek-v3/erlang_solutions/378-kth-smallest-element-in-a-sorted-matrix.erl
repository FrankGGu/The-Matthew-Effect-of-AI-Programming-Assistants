-spec kth_smallest(Matrix :: [[integer()]], K :: integer()) -> integer().
kth_smallest(Matrix, K) ->
    N = length(Matrix),
    Min = lists:nth(1, lists:nth(1, Matrix)),
    Max = lists:nth(N, lists:nth(N, Matrix)),
    binary_search(Matrix, Min, Max, K).

binary_search(Matrix, Min, Max, K) ->
    if
        Min == Max -> Min;
        true ->
            Mid = (Min + Max) div 2,
            Count = count_less_or_equal(Matrix, Mid),
            if
                Count < K -> binary_search(Matrix, Mid + 1, Max, K);
                true -> binary_search(Matrix, Min, Mid, K)
            end
    end.

count_less_or_equal(Matrix, Target) ->
    N = length(Matrix),
    count_less_or_equal(Matrix, Target, N, 1, 0).

count_less_or_equal(Matrix, Target, N, I, Count) when I =< N ->
    Row = lists:nth(I, Matrix),
    J = find_last_less_or_equal(Row, Target, 1, N),
    count_less_or_equal(Matrix, Target, N, I + 1, Count + J);
count_less_or_equal(_Matrix, _Target, _N, _I, Count) ->
    Count.

find_last_less_or_equal(Row, Target, Low, High) ->
    if
        Low > High -> High;
        true ->
            Mid = (Low + High) div 2,
            MidVal = lists:nth(Mid, Row),
            if
                MidVal =< Target -> find_last_less_or_equal(Row, Target, Mid + 1, High);
                true -> find_last_less_or_equal(Row, Target, Low, Mid - 1)
            end
    end.