-module(solution).
-export([tupleSameProduct/1]).

tupleSameProduct(Nums) ->
    Len = length(Nums),
    ProductCounts = maps:new(),

    ProductCountsFinal = calculate_product_counts(Nums, Len, 0, ProductCounts),

    calculate_total_tuples(ProductCountsFinal, 0).

calculate_product_counts(Nums, Len, I, AccMap) when I < Len - 1 ->
    NumI = lists:nth(I + 1, Nums),
    calculate_product_counts_inner(Nums, Len, I, NumI, I + 1, AccMap);
calculate_product_counts(_Nums, _Len, _I, AccMap) ->
    AccMap.

calculate_product_counts_inner(Nums, Len, I, NumI, J, AccMap) when J < Len ->
    NumJ = lists:nth(J + 1, Nums),
    Product = NumI * NumJ,

    NewAccMap = maps:update_with(Product, fun(Count) -> Count + 1 end, 1, AccMap),

    calculate_product_counts_inner(Nums, Len, I, NumI, J + 1, NewAccMap);
calculate_product_counts_inner(Nums, Len, I, _NumI, _J, AccMap) ->
    calculate_product_counts(Nums, Len, I + 1, AccMap).

calculate_total_tuples(ProductCountsMap, Total) ->
    maps:fold(fun(_Product, Count, Acc) ->
        if
            Count >= 2 ->
                Acc + (Count * (Count - 1) * 4);
            true ->
                Acc
        end
    end, Total, ProductCountsMap).