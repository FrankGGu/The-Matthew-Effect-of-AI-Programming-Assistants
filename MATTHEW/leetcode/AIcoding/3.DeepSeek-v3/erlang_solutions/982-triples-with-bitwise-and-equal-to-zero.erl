-spec count_triplets(List :: [integer()]) -> integer().
count_triplets(List) ->
    N = length(List),
    Count = 0,
    count_triplets(List, N, Count).

count_triplets(_, 0, Count) -> Count;
count_triplets(List, N, Count) ->
    I = lists:nth(N, List),
    NewCount = count_pairs(List, N - 1, I, Count),
    count_triplets(List, N - 1, NewCount).

count_pairs(_, 0, _, Count) -> Count;
count_pairs(List, M, I, Count) ->
    J = lists:nth(M, List),
    NewCount = count_singles(List, M - 1, I band J, Count),
    count_pairs(List, M - 1, I, NewCount).

count_singles(_, 0, _, Count) -> Count;
count_singles(List, K, IJ, Count) ->
    case lists:nth(K, List) band IJ of
        0 -> count_singles(List, K - 1, IJ, Count + 1);
        _ -> count_singles(List, K - 1, IJ, Count)
    end.