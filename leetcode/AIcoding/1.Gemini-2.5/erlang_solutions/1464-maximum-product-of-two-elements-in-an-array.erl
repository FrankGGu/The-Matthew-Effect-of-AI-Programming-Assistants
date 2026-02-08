-module(solution).
-export([max_product/1]).

-spec max_product(Nums :: [integer()]) -> integer().
max_product(Nums) ->
    SortedDesc = lists:sort(fun(A, B) -> A >= B end, Nums),
    [Max1, Max2 | _] = SortedDesc,
    (Max1 - 1) * (Max2 - 1).