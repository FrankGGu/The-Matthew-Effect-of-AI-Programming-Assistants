-spec maximum_sum(Nums :: [integer()]) -> integer().
maximum_sum(Nums) ->
    N = length(Nums),
    MaxK = trunc(math:sqrt(N)) + 1,
    lists:max([sum_square(Nums, K) || K <- lists:seq(1, MaxK)]).

sum_square(Nums, K) ->
    lists:sum([lists:nth(I * I * K, Nums) || I <- lists:seq(1, trunc(math:sqrt(length(Nums) / K))), I * I * K =< length(Nums)]).