-spec num_subarray_product_less_than_k(Nums :: [integer()], K :: integer()) -> integer().
num_subarray_product_less_than_k(Nums, K) ->
    case K =< 1 of
        true -> 0;
        false ->
            num_subarray_product_less_than_k(Nums, K, 1, 0, 0)
    end.

num_subarray_product_less_than_k([], _K, _Product, _Left, Ans) ->
    Ans;
num_subarray_product_less_than_k([Num | Rest], K, Product, Left, Ans) ->
    NewProduct = Product * Num,
    NewLeft = adjust_left(NewProduct, K, Left, [Num | Rest]),
    NewAns = Ans + (length([Num | Rest]) - NewLeft),
    num_subarray_product_less_than_k(Rest, K, NewProduct div lists:nth(NewLeft + 1, [Num | Rest]), NewLeft, NewAns).

adjust_left(Product, K, Left, Nums) when Product >= K ->
    adjust_left(Product div lists:nth(Left + 1, Nums), K, Left + 1, Nums);
adjust_left(_Product, _K, Left, _Nums) ->
    Left.