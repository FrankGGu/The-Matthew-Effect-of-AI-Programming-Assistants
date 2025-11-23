-spec missing_number(Nums :: [integer()]) -> integer().
missing_number(Nums) ->
    N = length(Nums),
    Sum = lists:sum(Nums),
    ExpectedSum = N * (N + 1) div 2,
    ExpectedSum - Sum.