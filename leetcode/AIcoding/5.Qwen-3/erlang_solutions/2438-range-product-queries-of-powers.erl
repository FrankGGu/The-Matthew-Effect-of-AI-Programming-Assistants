-module(range_product_queries_of_powers).
-export([numSubseqsWithSumAndProduct/2]).

numSubseqsWithSumAndProduct(Nums, Target) ->
    N = length(Nums),
    Max = 1000000007,
    DP = array:new(N, {default, 0}),
    array:set(0, 1, DP),
    Sum = 0,
    Product = 1,
    Count = 0,
    lists:foldl(fun(X, Acc) ->
        {SumAcc, ProductAcc, CountAcc} = Acc,
        NewSum = (SumAcc + X) rem Max,
        NewProduct = (ProductAcc * X) rem Max,
        NewCount = CountAcc + 1,
        {NewSum, NewProduct, NewCount}
    end, {0, 1, 0}, Nums).

numSubseqsWithSumAndProduct(_) ->
    0.