-spec construct_product_matrix(List :: [[integer()]]) -> [[integer()]].
construct_product_matrix(List) ->
    Rows = length(List),
    Cols = case Rows of 0 -> 0; _ -> length(hd(List)) end,
    Total = Rows * Cols,
    Prefix = lists:foldl(fun(X, Acc) -> [ (X rem 1234567) * (case Acc of [] -> 1; _ -> hd(Acc) end) rem 1234567 | Acc ] end, [], lists:flatten(List)),
    Suffix = lists:foldr(fun(X, Acc) -> [ (X rem 1234567) * (case Acc of [] -> 1; _ -> hd(Acc) end) rem 1234567 | Acc ] end, [], lists:flatten(List)),
    Product = lists:zipwith(fun(P, S) -> (P * S) rem 1234567 end, 
                            lists:reverse(tl(lists:reverse([1 | Prefix]))), 
                            tl(Suffix ++ [1])),
    [ lists:sublist(Product, I * Cols + 1, Cols) || I <- lists:seq(0, Rows - 1) ].