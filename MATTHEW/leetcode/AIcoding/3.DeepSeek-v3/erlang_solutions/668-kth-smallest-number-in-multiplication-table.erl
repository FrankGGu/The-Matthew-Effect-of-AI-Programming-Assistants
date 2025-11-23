-spec find_kth_number(M :: integer(), N :: integer(), K :: integer()) -> integer().
find_kth_number(M, N, K) ->
    Low = 1,
    High = M * N,
    binary_search(Low, High, M, N, K).

binary_search(Low, High, M, N, K) when Low < High ->
    Mid = Low + (High - Low) div 2,
    Count = count_less_or_equal(M, N, Mid),
    if
        Count < K ->
            binary_search(Mid + 1, High, M, N, K);
        true ->
            binary_search(Low, Mid, M, N, K)
    end;
binary_search(Low, _, _, _, _) ->
    Low.

count_less_or_equal(M, N, X) ->
    Count = 0,
    count_less_or_equal(1, M, N, X, Count).

count_less_or_equal(I, M, N, X, Count) when I =< M ->
    Add = min(X div I, N),
    if
        Add =:= 0 ->
            Count;
        true ->
            count_less_or_equal(I + 1, M, N, X, Count + Add)
    end;
count_less_or_equal(_, _, _, _, Count) ->
    Count.