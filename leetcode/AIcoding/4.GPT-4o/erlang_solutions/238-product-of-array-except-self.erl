-spec product_except_self(Nums :: [integer()]) -> [integer()].
product_except_self(Nums) ->
    Product = lists:foldl(fun(X, Acc) -> Acc * X end, 1, Nums),
    product_helper(Nums, Product, []).

product_helper([], _, Acc) -> lists:reverse(Acc);
product_helper([Head | Tail], Product, Acc) ->
    RestProduct = Product div Head,
    product_helper(Tail, RestProduct, [RestProduct | Acc]).
