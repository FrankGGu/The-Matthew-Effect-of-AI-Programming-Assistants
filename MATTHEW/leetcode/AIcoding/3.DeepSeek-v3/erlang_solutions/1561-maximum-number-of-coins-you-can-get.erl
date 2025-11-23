-spec max_coins(Piles :: [integer()]) -> integer().
max_coins(Piles) ->
    Sorted = lists:sort(fun(A, B) -> A > B end, Piles),
    N = length(Piles) div 3,
    lists:sum([lists:nth(I * 2 + 1, Sorted) || I <- lists:seq(0, N - 1)]).