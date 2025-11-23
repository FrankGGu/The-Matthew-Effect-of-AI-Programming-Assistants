-spec sum_subarrays(Arr :: [integer()]) -> integer().
sum_subarrays(Arr) ->
    N = length(Arr),
    lists:sum([lists:sum(lists:sublist(Arr, I, J)) || I <- lists:seq(1, N), J <- lists:seq(1, N - I + 1)]).