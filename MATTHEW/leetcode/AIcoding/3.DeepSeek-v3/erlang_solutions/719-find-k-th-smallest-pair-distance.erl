-spec smallest_distance_pair(Nums :: [integer()], K :: integer()) -> integer().
smallest_distance_pair(Nums, K) ->
    Sorted = lists:sort(Nums),
    N = length(Sorted),
    Low = 0,
    High = lists:nth(N, Sorted) - lists:nth(1, Sorted),
    binary_search(Sorted, K, Low, High).

binary_search(Nums, K, Low, High) ->
    if
        Low >= High -> Low;
        true ->
            Mid = (Low + High) div 2,
            Count = count_pairs(Nums, Mid),
            if
                Count < K -> binary_search(Nums, K, Mid + 1, High);
                true -> binary_search(Nums, K, Low, Mid)
            end
    end.

count_pairs(Nums, Mid) ->
    N = length(Nums),
    Count = 0,
    J = 1,
    count_pairs(Nums, Mid, N, Count, J).

count_pairs(Nums, Mid, N, Count, J) ->
    if
        J > N -> Count;
        true ->
            I = find_upper_bound(Nums, J, Mid),
            NewCount = Count + (J - I),
            count_pairs(Nums, Mid, N, NewCount, J + 1)
    end.

find_upper_bound(Nums, J, Mid) ->
    Low = 1,
    High = J,
    Target = lists:nth(J, Nums) - Mid,
    find_upper_bound(Nums, Target, Low, High).

find_upper_bound(Nums, Target, Low, High) ->
    if
        Low >= High -> Low;
        true ->
            Mid = (Low + High) div 2,
            if
                lists:nth(Mid, Nums) >= Target -> find_upper_bound(Nums, Target, Low, Mid);
                true -> find_upper_bound(Nums, Target, Mid + 1, High)
            end
    end.