-spec missing_number(Nums :: [integer()]) -> integer().
missing_number(Nums) ->
    N = length(Nums),
    ExpectedSum = N * (N + 1) div 2,
    ActualSum = lists:sum(Nums),
    ExpectedSum - ActualSum.