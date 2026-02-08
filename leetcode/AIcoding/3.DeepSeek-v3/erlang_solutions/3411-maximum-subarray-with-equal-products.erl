-spec max_product_subarray(Nums :: [integer()]) -> integer().
max_product_subarray(Nums) ->
    if 
        Nums =:= [] -> 0;
        true ->
            MaxProd = lists:nth(1, Nums),
            MinProd = lists:nth(1, Nums),
            Result = lists:nth(1, Nums),
            max_product_subarray(Nums, 2, MaxProd, MinProd, Result, length(Nums))
    end.

max_product_subarray(_, I, _, _, Result, Len) when I > Len ->
    Result;
max_product_subarray(Nums, I, MaxProd, MinProd, Result, Len) ->
    Current = lists:nth(I, Nums),
    if
        Current < 0 ->
            Temp = MaxProd,
            MaxProd = max(Current, MinProd * Current),
            MinProd = min(Current, Temp * Current);
        true ->
            MaxProd = max(Current, MaxProd * Current),
            MinProd = min(Current, MinProd * Current)
    end,
    NewResult = max(Result, MaxProd),
    max_product_subarray(Nums, I + 1, MaxProd, MinProd, NewResult, Len).