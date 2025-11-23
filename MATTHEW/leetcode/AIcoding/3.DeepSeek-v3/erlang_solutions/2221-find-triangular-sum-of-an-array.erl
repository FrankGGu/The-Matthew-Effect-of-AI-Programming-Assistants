-spec triangular_sum(Nums :: [integer()]) -> integer().
triangular_sum(Nums) ->
    triangular_sum(Nums, length(Nums)).

triangular_sum([Sum], 1) -> Sum;
triangular_sum(Nums, Len) ->
    NewNums = lists:map(fun(I) -> (lists:nth(I, Nums) + lists:nth(I + 1, Nums)) rem 10 end, lists:seq(1, Len - 1)),
    triangular_sum(NewNums, Len - 1).