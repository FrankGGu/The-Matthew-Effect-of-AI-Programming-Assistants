-spec minimum_sum(List :: [integer()]) -> integer().
minimum_sum(List) ->
    N = length(List),
    MinSum = lists:min([
        lists:nth(I, List) + lists:nth(J, List) + lists:nth(K, List)
        || I <- lists:seq(1, N),
           J <- lists:seq(I + 1, N),
           K <- lists:seq(J + 1, N),
           lists:nth(I, List) < lists:nth(J, List),
           lists:nth(K, List) < lists:nth(J, List)
    ]),
    MinSum.