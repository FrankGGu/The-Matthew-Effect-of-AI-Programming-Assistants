-spec trim_mean(Arr :: [integer()]) -> float().
trim_mean(Arr) ->
    Sorted = lists:sort(Arr),
    Len = length(Arr),
    Trim = trunc(Len * 0.05),
    Trimmed = lists:sublist(Sorted, Trim + 1, Len - 2 * Trim),
    Sum = lists:sum(Trimmed),
    Sum / length(Trimmed).