-spec minimize_max(Nums :: [integer()], P :: integer()) -> integer().
minimize_max(Nums, P) ->
    Sorted = lists:sort(Nums),
    N = length(Sorted),
    case P of
        0 -> 0;
        _ ->
            Low = 0,
            High = lists:nth(N, Sorted) - lists:nth(1, Sorted),
            binary_search(Sorted, P, Low, High)
    end.

binary_search(Nums, P, Low, High) ->
    if
        Low =:= High -> Low;
        true ->
            Mid = (Low + High) div 2,
            case count_pairs(Nums, Mid) >= P of
                true -> binary_search(Nums, P, Low, Mid);
                false -> binary_search(Nums, P, Mid + 1, High)
            end
    end.

count_pairs(Nums, MaxDiff) ->
    Count = 0,
    I = 1,
    N = length(Nums),
    count_pairs(Nums, MaxDiff, Count, I, N).

count_pairs(Nums, MaxDiff, Count, I, N) when I < N ->
    case lists:nth(I + 1, Nums) - lists:nth(I, Nums) =< MaxDiff of
        true -> count_pairs(Nums, MaxDiff, Count + 1, I + 2, N);
        false -> count_pairs(Nums, MaxDiff, Count, I + 1, N)
    end;
count_pairs(_, _, Count, _, _) -> Count.