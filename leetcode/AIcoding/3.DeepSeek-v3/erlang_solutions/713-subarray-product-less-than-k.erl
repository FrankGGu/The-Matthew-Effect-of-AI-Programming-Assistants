-spec num_subarray_product_less_than_k(Nums :: [integer()], K :: integer()) -> integer().
num_subarray_product_less_than_k(Nums, K) ->
    case K =< 1 of
        true -> 0;
        false ->
            {Count, Product, Left} = lists:foldl(
                fun(Num, {C, P, L}) ->
                    NewP = P * Num,
                    NewL = while_too_large(NewP, K, L, Nums),
                    NewC = C + (length(Nums) - NewL),
                    {NewC, NewP, NewL}
                end,
                {0, 1, 0},
                Nums
            ),
            Count
    end.

while_too_large(Product, K, Left, Nums) ->
    case Product >= K of
        true ->
            NewLeft = Left + 1,
            NewProduct = Product div lists:nth(NewLeft, Nums),
            while_too_large(NewProduct, K, NewLeft, Nums);
        false ->
            Left
    end.