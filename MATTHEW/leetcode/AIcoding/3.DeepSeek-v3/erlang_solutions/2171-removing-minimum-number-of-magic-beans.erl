-spec minimum_removal(Beans :: [integer()]) -> integer().
minimum_removal(Beans) ->
    Sorted = lists:sort(Beans),
    Sum = lists:sum(Sorted),
    N = length(Sorted),
    lists:min([Sum - (N - I) * X || {I, X} <- lists:zip(lists:seq(0, N - 1), Sorted)]).