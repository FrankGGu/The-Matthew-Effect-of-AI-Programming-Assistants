-spec average(Salary :: [integer()]) -> float().
average(Salary) ->
    Sorted = lists:sort(Salary),
    Trimmed = lists:sublist(Sorted, 2, length(Sorted) - 2),
    Sum = lists:sum(Trimmed),
    Sum / length(Trimmed).