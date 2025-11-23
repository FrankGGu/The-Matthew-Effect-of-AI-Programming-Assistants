-module(sales_inventory).
-export([num_non_negative/1]).

num_non_negative(Nums) ->
    lists:foldl(fun(X, Acc) -> if X >= 0 -> Acc + 1; true -> Acc end end, 0, Nums).