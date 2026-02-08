-module(sign_of_product).
-export([array_sign/1]).

array_sign(Nums) ->
    Product = lists:foldl(fun(X, Acc) -> X * Acc end, 1, Nums),
    if
        Product > 0 -> 1;
        Product < 0 -> -1;
        true -> 0
    end.