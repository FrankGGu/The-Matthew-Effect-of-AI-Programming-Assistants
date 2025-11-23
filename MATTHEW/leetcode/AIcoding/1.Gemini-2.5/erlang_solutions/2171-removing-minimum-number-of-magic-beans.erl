-spec remove_minimum_number_of_magic_beans(Beans :: [integer()]) -> integer().
remove_minimum_number_of_magic_beans(Beans) ->
    SortedBeans = lists:sort(Beans),
    TotalSum = lists:sum(SortedBeans),
    N = length(SortedBeans),

    MaxRemainingBeans = calculate_max_remaining(SortedBeans, N, 0, 0),

    TotalSum - MaxRemainingBeans.

calculate_max_remaining([], _N, _Index, Max) -> Max;
calculate_max_remaining([H|T], N, Index, CurrentMax) ->
    Remaining = H * (N - Index),
    NewMax = max(CurrentMax, Remaining),
    calculate_max_remaining(T, N, Index + 1, NewMax).