-spec count_monotonic_pairs(Nums :: [integer()]) -> integer().
count_monotonic_pairs(Nums) ->
    Pairs = [{I, J} || I <- lists:seq(0, length(Nums) - 1), 
                       J <- lists:seq(0, length(Nums) - 1), 
                       I < J, 
                       lists:nth(I + 1, Nums) =< lists:nth(J + 1, Nums)],
    length(Pairs).