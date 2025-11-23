-spec max_groups(UsageLimits :: [integer()]) -> integer().
max_groups(UsageLimits) ->
    Sorted = lists:sort(UsageLimits),
    max_groups(Sorted, 1, 0).

max_groups([], K, Count) ->
    Count;
max_groups([H | T], K, Count) ->
    if
        H >= K ->
            max_groups(T, K + 1, Count + 1);
        true ->
            max_groups(T, K, Count)
    end.