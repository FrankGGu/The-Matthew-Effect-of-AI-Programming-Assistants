-module(solution).
-export([range_product/3]).

range_product(N, L, R) ->
    Powers = lists:map(fun(X) -> math:pow(2, X) end, lists:seq(0, N-1)),
    Product = lists:foldl(fun(X, Acc) -> Acc * X end, 1, lists:sublist(Powers, L+1, R-L+1)),
    round(Product).